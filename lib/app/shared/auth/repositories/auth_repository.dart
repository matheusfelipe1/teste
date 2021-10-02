import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:joinder_app/app/shared/auth/repositories/iauth_repository.dart';

import 'package:joinder_app/app/shared/custom_http/custom_http.dart';

import 'package:joinder_app/app/shared/models/facebook_profile.dart';
import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

@observable
Profile profile;

class AuthRepository implements IAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _http = Modular.get<CustomHttp>();
  static const platform = const MethodChannel('mobilus.joinder/logout');

  @override
  Future<FirebaseUser> getFirebaseUser() async {
    try {
      final user = await _auth.currentUser();
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Profile> getUserProfile() async {
    Profile profile;
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        final result = await _http.client.get(
            '/profiles/${user.uid}/using-firebase-uid?cache=${Uuid().v1()}');
        final json = result.data;
        print(json['results'][0]);
        if (json is Map) {
          if (json['results'] is List)
            return new Profile.fromJson(json['results'][0]);
        }
      }
      return null;
    } catch (e) {
      print("err $e");
      return null;
    }
  }

  @override
  Future<String> getToken() async {
    try {
      final user = await _auth.currentUser();
      final idToken = await user.getIdToken();
      return idToken.token;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<FacebookProfile> signInWithFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult =
        await facebookLogin.logIn(['email', 'public_profile']);
    if (facebookLoginResult.accessToken != null) {
      try {
        final token = facebookLoginResult.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
        final graphPicture = await http.get(
            'https://graph.facebook.com/v2.12/me/picture?redirect=0&height=1000&width=1000&type=normal&access_token=&access_token=$token');
        final json = jsonDecode(graphResponse.body);
        final jsonPicture = jsonDecode(graphPicture.body);
        json['accessToken'] = token;

        if (jsonPicture != null && jsonPicture['data'] != null)
          json['picture'] = jsonPicture['data']['url'];
        else
          json['picture'] = "";

        final profile = FacebookProfile.fromJson(json);
        return profile;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<FirebaseUser> signInWithCredential(AuthCredential credential) async {
    try {
      final result = await _auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<FirebaseUser> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      throw e;
    }
  }

  @action
  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    try {
      return await _auth.sendPasswordResetEmail(
        email: email,
      );
    } catch (e) {
      throw e;
    }
  }

  @override
  void verifyPhoneNumber(
      String phoneNumber,
      Function(AuthCredential) verificationCompleted,
      Function(AuthException) verificationFailed,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  Future<bool> getUserStatus() async {
    try {
      Response result =
          await _http.client.post('/users/email/verify', data: {});
      print(result.statusCode);
      if (result.statusCode == 200 ||
          result.statusCode == 201 ||
          result.statusCode == 204)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> sendToConfirmEmail() async {
    try {
      Response result =
          await _http.client.post('/users/email/confirm', data: {});
      if (result.statusCode == 200 ||
          result.statusCode == 201 ||
          result.statusCode == 204)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  @override
  void registerDeviceToken(String token, String userId) async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String model = "";
      String osVersion = "";
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        model = iosInfo.model;
        osVersion = iosInfo.systemVersion;
      } else {
        AndroidDeviceInfo android = await deviceInfo.androidInfo;
        model = android.model;
        osVersion = android.version.sdkInt.toString();
      }
      final map = {
        "device_id": token,
        "user_id": userId,
        "os": Platform.isIOS ? "iOS" : "Android",
        "os_version": osVersion,
        "device_model": model
      };
      dynamic result =
          await _http.client.post('/users/devices', data: json.encode(map));
      print(result);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signOut() async {
    //  if(Platform.isIOS)
    //    await platform.invokeMethod('logout');
    return _auth.signOut();
  }
}
