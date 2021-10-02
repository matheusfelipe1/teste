// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PhoneAuthController on _PhoneAuthBase, Store {
  final _$pageAtom = Atom(name: '_PhoneAuthBase.page');

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

  final _$pageControllerAtom = Atom(name: '_PhoneAuthBase.pageController');

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

  final _$pageTitleAtom = Atom(name: '_PhoneAuthBase.pageTitle');

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

  final _$hasErrorAtom = Atom(name: '_PhoneAuthBase.hasError');

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

  final _$errorMessageAtom = Atom(name: '_PhoneAuthBase.errorMessage');

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

  final _$phoneNumberAtom = Atom(name: '_PhoneAuthBase.phoneNumber');

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  final _$verificationIdAtom = Atom(name: '_PhoneAuthBase.verificationId');

  @override
  String get verificationId {
    _$verificationIdAtom.reportRead();
    return super.verificationId;
  }

  @override
  set verificationId(String value) {
    _$verificationIdAtom.reportWrite(value, super.verificationId, () {
      super.verificationId = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_PhoneAuthBase.isLoading');

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

  final _$smsResultAtom = Atom(name: '_PhoneAuthBase.smsResult');

  @override
  AuthStatus get smsResult {
    _$smsResultAtom.reportRead();
    return super.smsResult;
  }

  @override
  set smsResult(AuthStatus value) {
    _$smsResultAtom.reportWrite(value, super.smsResult, () {
      super.smsResult = value;
    });
  }

  final _$submitCodeAsyncAction = AsyncAction('_PhoneAuthBase.submitCode');

  @override
  Future submitCode(String code) {
    return _$submitCodeAsyncAction.run(() => super.submitCode(code));
  }

  final _$_PhoneAuthBaseActionController =
      ActionController(name: '_PhoneAuthBase');

  @override
  dynamic submitPhone(BuildContext context) {
    final _$actionInfo = _$_PhoneAuthBaseActionController.startAction(
        name: '_PhoneAuthBase.submitPhone');
    try {
      return super.submitPhone(context);
    } finally {
      _$_PhoneAuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_PhoneAuthBaseActionController.startAction(
        name: '_PhoneAuthBase.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_PhoneAuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(int newPage) {
    final _$actionInfo = _$_PhoneAuthBaseActionController.startAction(
        name: '_PhoneAuthBase.setPage');
    try {
      return super.setPage(newPage);
    } finally {
      _$_PhoneAuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tryAgain() {
    final _$actionInfo = _$_PhoneAuthBaseActionController.startAction(
        name: '_PhoneAuthBase.tryAgain');
    try {
      return super.tryAgain();
    } finally {
      _$_PhoneAuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onBack() {
    final _$actionInfo = _$_PhoneAuthBaseActionController.startAction(
        name: '_PhoneAuthBase.onBack');
    try {
      return super.onBack();
    } finally {
      _$_PhoneAuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
page: ${page},
pageController: ${pageController},
pageTitle: ${pageTitle},
hasError: ${hasError},
errorMessage: ${errorMessage},
phoneNumber: ${phoneNumber},
verificationId: ${verificationId},
isLoading: ${isLoading},
smsResult: ${smsResult}
    ''';
  }
}
