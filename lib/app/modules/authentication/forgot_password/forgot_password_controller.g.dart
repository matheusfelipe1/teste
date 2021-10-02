// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForgotPasswordController on _ForgotPasswordBase, Store {
  final _$pageAtom = Atom(name: '_ForgotPasswordBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$pageControllerAtom = Atom(name: '_ForgotPasswordBase.pageController');

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  final _$pageTitleAtom = Atom(name: '_ForgotPasswordBase.pageTitle');

  @override
  String get pageTitle {
    _$pageTitleAtom.reportRead();
    return super.pageTitle;
  }

  @override
  set pageTitle(String value) {
    _$pageTitleAtom.reportWrite(value, super.pageTitle, () {
      super.pageTitle = value;
    });
  }

  final _$forgotPasswordStatusAtom =
      Atom(name: '_ForgotPasswordBase.forgotPasswordStatus');

  @override
  ForgotPasswordStatus get forgotPasswordStatus {
    _$forgotPasswordStatusAtom.reportRead();
    return super.forgotPasswordStatus;
  }

  @override
  set forgotPasswordStatus(ForgotPasswordStatus value) {
    _$forgotPasswordStatusAtom.reportWrite(value, super.forgotPasswordStatus,
        () {
      super.forgotPasswordStatus = value;
    });
  }

  final _$hasErrorAtom = Atom(name: '_ForgotPasswordBase.hasError');

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

  final _$isButtonDisabledAtom =
      Atom(name: '_ForgotPasswordBase.isButtonDisabled');

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

  final _$isLoadingAtom = Atom(name: '_ForgotPasswordBase.isLoading');

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

  final _$errorMessageAtom = Atom(name: '_ForgotPasswordBase.errorMessage');

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

  final _$forgotPasswordAtom = Atom(name: '_ForgotPasswordBase.forgotPassword');

  @override
  ForgotPassword get forgotPassword {
    _$forgotPasswordAtom.reportRead();
    return super.forgotPassword;
  }

  @override
  set forgotPassword(ForgotPassword value) {
    _$forgotPasswordAtom.reportWrite(value, super.forgotPassword, () {
      super.forgotPassword = value;
    });
  }

  final _$showPasswordAtom = Atom(name: '_ForgotPasswordBase.showPassword');

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

  final _$sendPasswordResetEmailAsyncAction =
      AsyncAction('_ForgotPasswordBase.sendPasswordResetEmail');

  @override
  Future sendPasswordResetEmail(String email, BuildContext context) {
    return _$sendPasswordResetEmailAsyncAction
        .run(() => super.sendPasswordResetEmail(email, context));
  }

  final _$_ForgotPasswordBaseActionController =
      ActionController(name: '_ForgotPasswordBase');

  @override
  void setPage(int newPage) {
    final _$actionInfo = _$_ForgotPasswordBaseActionController.startAction(
        name: '_ForgotPasswordBase.setPage');
    try {
      return super.setPage(newPage);
    } finally {
      _$_ForgotPasswordBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tryAgain() {
    final _$actionInfo = _$_ForgotPasswordBaseActionController.startAction(
        name: '_ForgotPasswordBase.tryAgain');
    try {
      return super.tryAgain();
    } finally {
      _$_ForgotPasswordBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onBack() {
    final _$actionInfo = _$_ForgotPasswordBaseActionController.startAction(
        name: '_ForgotPasswordBase.onBack');
    try {
      return super.onBack();
    } finally {
      _$_ForgotPasswordBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validateEmail(String text) {
    final _$actionInfo = _$_ForgotPasswordBaseActionController.startAction(
        name: '_ForgotPasswordBase.validateEmail');
    try {
      return super.validateEmail(text);
    } finally {
      _$_ForgotPasswordBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validatePassword(String text) {
    final _$actionInfo = _$_ForgotPasswordBaseActionController.startAction(
        name: '_ForgotPasswordBase.validatePassword');
    try {
      return super.validatePassword(text);
    } finally {
      _$_ForgotPasswordBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<T> map<T>(List<dynamic> list, Function handler) {
    final _$actionInfo = _$_ForgotPasswordBaseActionController.startAction(
        name: '_ForgotPasswordBase.map<T>');
    try {
      return super.map<T>(list, handler);
    } finally {
      _$_ForgotPasswordBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
page: ${page},
pageController: ${pageController},
pageTitle: ${pageTitle},
forgotPasswordStatus: ${forgotPasswordStatus},
hasError: ${hasError},
isButtonDisabled: ${isButtonDisabled},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
forgotPassword: ${forgotPassword},
showPassword: ${showPassword}
    ''';
  }
}
