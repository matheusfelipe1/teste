import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:joinder_app/app/shared/enums/auth_type.dart';
import 'package:joinder_app/app/shared/enums/auth_status.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

part 'phone_auth_controller.g.dart';

class PhoneAuthController = _PhoneAuthBase with _$PhoneAuthController;

abstract class _PhoneAuthBase with Store {
  final _authController = Modular.get<AuthController>();

  @observable
  int page = 0;

  @observable
  PageController pageController;

  @observable
  String pageTitle = "";

  @observable
  bool hasError = false;

  @observable
  String errorMessage = "";

  // SMS Validation
  @observable
  String phoneNumber = "";
  
  @observable
  String verificationId = "";

  @observable
  bool isLoading = false;
  
  @observable
  AuthStatus smsResult = AuthStatus.loading;

  _PhoneAuthBase({int initialPage}) {
    if (initialPage != null) page = initialPage;
    _init();
  }

  _init() {
    pageController = PageController(initialPage: page);
    pageTitle = _getPageTitle();
  }

  @action
  submitPhone(BuildContext context) {
    var formattedPhone = "";
    formattedPhone = phoneNumber;
    formattedPhone = formattedPhone.replaceAll("(", "");
    formattedPhone = formattedPhone.replaceAll(")", "");
    formattedPhone = formattedPhone.replaceAll("-", "");
    formattedPhone = formattedPhone.replaceAll(" ", "");
    formattedPhone = "+55$formattedPhone";
    _authController.doPhoneAuthentication(formattedPhone, (credential) {
      print(credential);
    }, (error) async {
      String message = "";
      switch (error.code) {
        case "verifyPhoneNumberError":
          message = "Você excedeu o limite de tentativas de autenticação. Por favor, tente novamente mais tarde.";
          break;
        default:
          message = "Algo deu errado.";
          break;
      }
      await AppUtils.defaultDialog(context, true, "OPS...",
                        message, true,
                        buttonText: "OK");
    }, (verificationId, [code]) async {
      this.verificationId = verificationId;
      await AppUtils.defaultDialog(context, false, "SMS ENVIADO!",
                        "Verifique a sua caixa de mensagens.", true,
                        buttonText: "OK");
      if(page != 1)
        setPage(1);
    }, (verificationId) {
      print(verificationId);
    });
  }

  @action
  submitCode(String code) async {
    isLoading = true;
    var credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
    final result = await _authController.signInWithCredential(credential, AuthType.phone);
    smsResult = result ? AuthStatus.logged : AuthStatus.unlogged;
    isLoading = false;
    if(smsResult == AuthStatus.logged)
      _authController.onStateChanged();
  }

  @action
  void setPhone(String value) {
    phoneNumber = value;
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

  String _getPageTitle() {
    if (hasError)
      return "Erro";
    else
      switch (page) {
        case 0:
          return "Meu número de telefone";
        case 1:
          return "Meu código";
        default:
          return "Meu número de telefone";
      }
  }
}
