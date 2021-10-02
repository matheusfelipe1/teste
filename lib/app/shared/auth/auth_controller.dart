import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joinder_app/app/modules/authentication/signup/signup_controller.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:joinder_app/app/shared/auth/repositories/iauth_repository.dart';

import 'package:joinder_app/app/shared/models/facebook_profile.dart';
import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:joinder_app/app/shared/enums/auth_status.dart';
import 'package:joinder_app/app/shared/enums/auth_type.dart';

import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthBase with _$AuthController;

abstract class _AuthBase with Store {
  final IAuthRepository _authRepository = Modular.get();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  // Storage Key
  static const String FACEBOOK_KEY = "facebookProfile";
  static const String PROFILE_KEY = "profile";

  @observable
  FirebaseUser currentUser;

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  AuthType type = AuthType.none;

  @observable
  FacebookProfile facebookProfile;

  @observable
  Profile profile;

  @observable
  bool isEmailActivated = false;

  @observable
  Location location = new Location();

  bool _serviceEnabled = false;

  @observable
  PermissionStatus _permissionGranted;

  @observable
  LocationData locationData;

  @observable
  String currentChat;

  _AuthBase() {
    Future.delayed(Duration(seconds: 3), () => {_init()});
  }

  _init() async {
    currentUser = await _authRepository.getFirebaseUser();
    await onAuthStatus();
    onStateChanged();
  }

  @action
  doPhoneAuthentication(
      String phoneNumber,
      Function(AuthCredential) verificationCompleted,
      Function(AuthException) verificationFailed,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout) {
    _authRepository.verifyPhoneNumber(phoneNumber, verificationCompleted,
        verificationFailed, codeSent, codeAutoRetrievalTimeout);
  }

  @action
  Future<FacebookProfile> doFacebookLogin() async {
    final prflFacebook = await _authRepository.signInWithFacebook();
    if (prflFacebook != null) {
      facebookProfile = prflFacebook;
      await AppUtils.saveObjectOnStorage(FACEBOOK_KEY, prflFacebook.toJson());
    }
    return prflFacebook;
  }

  @action
  Future<bool> signInWithCredential(
      AuthCredential credential, AuthType selectionType) async {
    currentUser = await _authRepository.signInWithCredential(credential);
    if (currentUser != null) {
      type = selectionType;
      await onAuthStatus();
      return true;
    }
    return false;
  }

  @action
  Future<bool> createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    var shared = await SharedPreferences.getInstance();
    String token;
    try {
      currentUser =
          await _authRepository.createUserWithEmailAndPassword(email, password);
      if (currentUser != null) {
        await currentUser.getIdToken().then((value) => token = value.token);
        await shared.setString('token', token);
        type = AuthType.email;
        await onAuthStatus();
        return true;
      }
      return false;
    } catch (e) {
      String message = getMsgErrorFirebase(e.code);
      await AppUtils.defaultDialog(context, true, "OPS...", message, true,
          buttonText: "OK");
      return false;
    }
  }

  @action
  Future<bool> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      currentUser =
          await _authRepository.signInWithEmailAndPassword(email, password);
      if (currentUser != null) {
        type = AuthType.email;
        await onAuthStatus();
        return true;
      }
      return false;
    } catch (e) {
      String message = getMsgErrorFirebase(e.code);
      await AppUtils.defaultDialog(context, true, "OPS...", message, true,
          buttonText: "OK");
      return false;
    }
  }

  @action
  Future<bool> sendPasswordResetEmail(
      String email, BuildContext context) async {
    try {
      await _authRepository.sendPasswordResetEmail(email, context);
      await showSnackbar(context, '', 'Verifique seu email: "$email"');
      return true;
    } catch (e) {
      String message = getMsgErrorFirebase(e.code);
      await AppUtils.defaultDialog(context, true, "OPS...", message, true,
          buttonText: "OK");
      return false;
    }
  }

  @action
  geoLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    while (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();
    while (_permissionGranted == PermissionStatus.denied ||
        _permissionGranted == PermissionStatus.deniedForever) {
      _permissionGranted = await location.requestPermission();
    }
    locationData = await location.getLocation();
  }

  @action
  Future<String> getToken() async {
    return await _authRepository.getToken();
  }

  @action
  signOut() async {
    status = AuthStatus.unlogged;
    profile = null;
    currentUser = null;
    isEmailActivated = false;
    await AppUtils.removeObjectFromStorage(PROFILE_KEY);
    if (facebookProfile != null) {
      facebookProfile = null;
      await AppUtils.removeObjectFromStorage(FACEBOOK_KEY);
    }
    await _authRepository.signOut();
    onStateChanged();
  }

  @action
  onAuthStatus() async {
    if (currentUser == null)
      status = AuthStatus.unlogged;
    else {
      status = AuthStatus.logged;
      // Register Device Token.
      if (Platform.isIOS) {
        iosSubscription = _fcm.onIosSettingsRegistered.listen((data) async {
          _fcm.getToken().then((data) async =>
              {_authRepository.registerDeviceToken(data, currentUser.uid)});
        });

        _fcm.requestNotificationPermissions(IosNotificationSettings());
      } else {
        _fcm.getToken().then((data) async =>
            {_authRepository.registerDeviceToken(data, currentUser.uid)});
      }

      if (currentUser.phoneNumber != null && currentUser.phoneNumber != "")
        type = AuthType.phone;
      else if ((currentUser.displayName != null ||
              currentUser.photoUrl != null) &&
          (currentUser.displayName != "" || currentUser.photoUrl != "")) {
        type = AuthType.facebook;
        final json = await AppUtils.getObjectFromStorage(FACEBOOK_KEY);
        facebookProfile = json != null ? FacebookProfile.fromJson(json) : null;
      } else {
        type = AuthType.email;
      }

      try {
        final result = await _authRepository.getUserProfile();
        print(result);
        if (result != null) {
          profile = result;
          await AppUtils.saveObjectOnStorage(PROFILE_KEY, result.toJson());
        } else
          profile = null;
      } catch (e) {
        profile = null;
      }
      if (type == AuthType.facebook) {
        isEmailActivated = true;
      } else {
        isEmailActivated = await _authRepository.getUserStatus();
      }
    }
  }

  @action
  onStateChanged() {
    print(isEmailActivated);
    if (status == AuthStatus.unlogged) {
      Modular.to.pushReplacementNamed('/auth/login');
    } else {
      if (profile != null) {
        // TODO: Verificar localização.
        if (isEmailActivated)
          Modular.to.pushReplacementNamed('/home');
        else
          Modular.to.pushReplacementNamed('/home/waiting-confirm');
      } else {
        Modular.to.pushNamed('/auth/sign-up');
      }
    }
  }

  Future<Profile> getUserProfile() async {
    try {
      final result = await _authRepository.getUserProfile();
      if (result != null) {
        profile = result;
        await AppUtils.saveObjectOnStorage(PROFILE_KEY, result.toJson());
      } else
        profile = null;
      return profile;
    } catch (e) {
      profile = null;
      return profile;
    }
  }

  // MARK: Utils
  getMsgErrorFirebase(String errorCode) {
    String msg = '';
    switch (errorCode) {
      case 'ERROR_INVALID_EMAIL':
        msg = 'Email está com formato inválido.';
        break;
      case 'ERROR_WRONG_PASSWORD':
        msg = 'A senha informada está incorreta.';
        break;
      case 'ERROR_USER_NOT_FOUND':
        msg = 'Usuário informado não foi encontrado.';
        break;
      case 'ERROR_USER_DISABLED':
        msg = 'Seu usuário foi desativado.';
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        msg = 'Você realizou muitas requisições. Tente novamente mais tarde.';
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        msg = 'Essa operação não é permitida.';
        break;
      case 'ERROR_WEAK_PASSWORD':
        msg = 'A Senha informada é fraca. Tente informar outra senha.';
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        msg = 'O email informado já está sendo usado...';
        break;
      default:
        msg = 'Erro ao realizar login.';
    }
    return msg;
  }

  @action
  showSnackbar(BuildContext context, String typeSnackBar, String message) {
    String iconSnackBar;
    Color backgroundSnackBar;
    if (typeSnackBar == 'warning') {
      iconSnackBar = 'assets/images/ic_alerta_branco.png';
      backgroundSnackBar = AppColors.backgroundYellow;
    } else if (typeSnackBar == 'error') {
      iconSnackBar = 'assets/images/ic_alerta_branco.png';
      backgroundSnackBar = AppColors.error;
    } else {
      iconSnackBar = 'assets/images/ic_check_branco.png';
      backgroundSnackBar = AppColors.backgroundGreen;
    }
    final snackBar = SnackBar(
        backgroundColor: backgroundSnackBar,
        duration: Duration(seconds: 60),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'X',
          textColor: Colors.white,
          onPressed: () {},
        ),
        content: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child: Image.asset(
                        iconSnackBar,
                        width: 22,
                      )),
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        message,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: AppColors.white,
                            fontSize: 12,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
