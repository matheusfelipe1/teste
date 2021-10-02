// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrar_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EntrarController on _EntrarBase, Store {
  final _$hasErrorAtom = Atom(name: '_EntrarBase.hasError');

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_EntrarBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$isButtonDisabledAtom = Atom(name: '_EntrarBase.isButtonDisabled');

  @override
  bool get isButtonDisabled {
    _$isButtonDisabledAtom.reportRead();
    return super.isButtonDisabled;
  }

  @override
  set isButtonDisabled(bool value) {
    _$isButtonDisabledAtom.reportWrite(value, super.isButtonDisabled, () {
      super.isButtonDisabled = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_EntrarBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$loginResultAtom = Atom(name: '_EntrarBase.loginResult');

  @override
  AuthStatus get loginResult {
    _$loginResultAtom.reportRead();
    return super.loginResult;
  }

  @override
  set loginResult(AuthStatus value) {
    _$loginResultAtom.reportWrite(value, super.loginResult, () {
      super.loginResult = value;
    });
  }

  final _$showPasswordAtom = Atom(name: '_EntrarBase.showPassword');

  @override
  bool get showPassword {
    _$showPasswordAtom.reportRead();
    return super.showPassword;
  }

  @override
  set showPassword(bool value) {
    _$showPasswordAtom.reportWrite(value, super.showPassword, () {
      super.showPassword = value;
    });
  }

  final _$doEmailPasswordLoginAsyncAction =
      AsyncAction('_EntrarBase.doEmailPasswordLogin');

  @override
  Future doEmailPasswordLogin(
      String email, String password, BuildContext context) {
    return _$doEmailPasswordLoginAsyncAction
        .run(() => super.doEmailPasswordLogin(email, password, context));
  }

  final _$_EntrarBaseActionController = ActionController(name: '_EntrarBase');

  @override
  String validateEmail(String text) {
    final _$actionInfo = _$_EntrarBaseActionController.startAction(
        name: '_EntrarBase.validateEmail');
    try {
      return super.validateEmail(text);
    } finally {
      _$_EntrarBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validatePassword(String text) {
    final _$actionInfo = _$_EntrarBaseActionController.startAction(
        name: '_EntrarBase.validatePassword');
    try {
      return super.validatePassword(text);
    } finally {
      _$_EntrarBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hasError: ${hasError},
errorMessage: ${errorMessage},
isButtonDisabled: ${isButtonDisabled},
isLoading: ${isLoading},
loginResult: ${loginResult},
showPassword: ${showPassword}
    ''';
  }
}
