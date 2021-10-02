// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_phone_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigPhoneController on _ConfigPhoneBase, Store {
  final _$pageAtom = Atom(name: '_ConfigPhoneBase.page');

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

  final _$pageControllerAtom = Atom(name: '_ConfigPhoneBase.pageController');

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

  final _$pageTitleAtom = Atom(name: '_ConfigPhoneBase.pageTitle');

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

  final _$hasErrorAtom = Atom(name: '_ConfigPhoneBase.hasError');

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

  final _$errorMessageAtom = Atom(name: '_ConfigPhoneBase.errorMessage');

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

  final _$completedAtom = Atom(name: '_ConfigPhoneBase.completed');

  @override
  bool get completed {
    _$completedAtom.reportRead();
    return super.completed;
  }

  @override
  set completed(bool value) {
    _$completedAtom.reportWrite(value, super.completed, () {
      super.completed = value;
    });
  }

  final _$_ConfigPhoneBaseActionController =
      ActionController(name: '_ConfigPhoneBase');

  @override
  void setPage(int newPage) {
    final _$actionInfo = _$_ConfigPhoneBaseActionController.startAction(
        name: '_ConfigPhoneBase.setPage');
    try {
      return super.setPage(newPage);
    } finally {
      _$_ConfigPhoneBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tryAgain() {
    final _$actionInfo = _$_ConfigPhoneBaseActionController.startAction(
        name: '_ConfigPhoneBase.tryAgain');
    try {
      return super.tryAgain();
    } finally {
      _$_ConfigPhoneBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onBack() {
    final _$actionInfo = _$_ConfigPhoneBaseActionController.startAction(
        name: '_ConfigPhoneBase.onBack');
    try {
      return super.onBack();
    } finally {
      _$_ConfigPhoneBaseActionController.endAction(_$actionInfo);
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
completed: ${completed}
    ''';
  }
}
