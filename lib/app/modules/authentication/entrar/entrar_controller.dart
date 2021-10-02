import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/enums/auth_status.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/validators/validators.dart';

part 'entrar_controller.g.dart';

class EntrarController = _EntrarBase with _$EntrarController;

abstract class _EntrarBase with Store {
  final _authController = Modular.get<AuthController>();

  @observable
  bool hasError = false;

  @observable
  String errorMessage = "";

  @observable
  bool isButtonDisabled = false;

  @observable
  bool isLoading = false;

  @observable
  AuthStatus loginResult = AuthStatus.loading;

  @observable
  bool showPassword;

  _EntrarBase({int initialPage}) {
    _init();
  }

  _init() {}

  @action
  String validateEmail(String text) {
    if (Validators.isValidEmail(text)) {
      return null;
    } else {
      return 'Email digitado não é válido';
    }
  }

  @action
  String validatePassword(String text) {
    if (Validators.isValidPassword(text)) {
      return null;
    } else {
      return 'A senha deve ter de 6 a 30 caracteres';
    }
  }

  bool validateForm(String password, String email) {
    if (Validators.isValidPassword(password) &&
        Validators.isValidEmail(email)) {
      return true;
    } else {
      return false;
    }
  }

  @action
  doEmailPasswordLogin(
      String email, String password, BuildContext context) async {
    isLoading = true;
    final result = await _authController.signInWithEmailAndPassword(
        email, password, context);
    loginResult = result ? AuthStatus.logged : AuthStatus.unlogged;
    isLoading = false;
    if (loginResult == AuthStatus.logged) _authController.onStateChanged();
  }
}
