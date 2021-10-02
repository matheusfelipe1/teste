import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/auth/repositories/iauth_repository.dart';

part 'waiting_confirm_email_controller.g.dart';

class WaitingConfirmEmailController = _WaitingConfirmEmailBase
    with _$WaitingConfirmEmailController;

abstract class _WaitingConfirmEmailBase with Store {
  final IAuthRepository _authRepository = Modular.get();
  final _authController = Modular.get<AuthController>();

  @observable
  bool hasError = false;

  @observable
  String errorMessage = "";

  @observable
  bool isLoading = false;
  
  @observable
  bool isVerifyLoading = false;

  _WaitingConfirmEmailBase({int initialPage}) {
    _init();
  }

  _init() {}

  @action
  verifyEmail(BuildContext context) async {
    isVerifyLoading = true;
    await _authController.onAuthStatus();
    isVerifyLoading = false;
    if (_authController.isEmailActivated) {
      _authController.onStateChanged();
    } else {
      _authController.showSnackbar(context, 'warning',
          'Tem certeza?. Não recebi sua confirmação de email. Dá uma olhadinha no seu email ou reenvie a solicitação de confirmação :)');
    }
  }

  @action
  sendToConfirmEmail(BuildContext context) async {
    isLoading = true;
    bool sendEmail = await _authRepository.sendToConfirmEmail();
    isLoading = false;
    if (sendEmail) {
      _authController.showSnackbar(context, '', 'Email reenviado ;)');
    } else {
      _authController.showSnackbar(
          context, 'warning', 'Erro ao enviar email, tente novamente.');
    }
  }
}
