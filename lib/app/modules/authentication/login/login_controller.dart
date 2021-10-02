import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/models/facebook_profile.dart';
import 'package:mobx/mobx.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:joinder_app/app/shared/enums/auth_type.dart';
import 'package:joinder_app/app/shared/enums/auth_status.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';

part 'login_controller.g.dart';

class LoginController = _LoginBase with _$LoginController;

abstract class _LoginBase with Store {
  final _authController = Modular.get<AuthController>();

  // Facebook Validation
  @observable
  bool isLoading = false;

  @observable
  AuthStatus facebookResult = AuthStatus.loading;

  _LoginBase() {
    _init();
  }

  _init() {}

  @action
  doFacebookLogin(BuildContext context) async {
    isLoading = true;
    final profile = await _authController.doFacebookLogin();
    if (profile != null &&
        (profile.accessToken != null && profile.accessToken != "")) {
      var credential =
          FacebookAuthProvider.getCredential(accessToken: profile.accessToken);

      _authController.facebookProfile = profile;
      final result = await _authController.signInWithCredential(
          credential, AuthType.facebook);
      facebookResult = result ? AuthStatus.logged : AuthStatus.unlogged;
      isLoading = false;
      if (facebookResult == AuthStatus.logged)
        _authController.onStateChanged();
      else {
        String message = "Não foi possível autenticar com o seu Facebook.";
        await AppUtils.defaultDialog(context, true, "OPS...", message, true,
            buttonText: "OK");
      }
    } else {
      isLoading = false;
      facebookResult = AuthStatus.unlogged;
      String message = "Não foi possível autenticar com o seu Facebook.";
      await AppUtils.defaultDialog(context, true, "OPS...", message, true,
          buttonText: "OK");
    }
  }
}
