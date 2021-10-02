import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/enums/forgot_password_status.dart';
import 'package:joinder_app/app/shared/models/forgot_password.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/validators/validators.dart';

part 'forgot_password_controller.g.dart';

class ForgotPasswordController = _ForgotPasswordBase
    with _$ForgotPasswordController;

abstract class _ForgotPasswordBase with Store {
  final _authController = Modular.get<AuthController>();

  @observable
  int page = 0;

  @observable
  PageController pageController;

  @observable
  String pageTitle = "";

  @observable
  ForgotPasswordStatus forgotPasswordStatus;

  @observable
  bool hasError = false;

  @observable
  bool isButtonDisabled = false;

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = "";

  @observable
  ForgotPassword forgotPassword;

  @observable
  bool showPassword;

  _ForgotPasswordBase({int initialPage}) {
    if (initialPage != null) page = initialPage;
    _init();
  }

  _init() {
    forgotPasswordStatus = ForgotPasswordStatus.waiting;
    forgotPassword = new ForgotPassword();
    pageController = PageController(initialPage: page);
    pageTitle = _getPageTitle();
  }

  @action
  void setPage(int newPage) {
    page = newPage;
    pageTitle = _getPageTitle();
    pageController.animateToPage(newPage,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @action
  void tryAgain() {
    hasError = false;
    errorMessage = "";
    pageTitle = _getPageTitle();
  }

  @action
  void onBack() {
    setPage(page - 1);
  }

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
      return false;
    } else {
      return true;
    }
  }

  String _getPageTitle() {
    if (hasError)
      return "Erro";
    else
      switch (page) {
        case 0:
          return "Insira seu e-mail";
        case 1:
          return "Insira seu código";
        case 2:
          return "Mudar senha";
        default:
          return "Insira seu e-mail";
      }
  }

  @action
  sendPasswordResetEmail(String email, BuildContext context) async {
    isLoading = true;
    var result = await _authController.sendPasswordResetEmail(email, context);
    isLoading = false;
  }

  // MARK: Utils
  @action
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}
