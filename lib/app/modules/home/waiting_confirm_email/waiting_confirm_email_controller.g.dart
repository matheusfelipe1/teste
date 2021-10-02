// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiting_confirm_email_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WaitingConfirmEmailController on _WaitingConfirmEmailBase, Store {
  final _$hasErrorAtom = Atom(name: '_WaitingConfirmEmailBase.hasError');

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

  final _$errorMessageAtom =
      Atom(name: '_WaitingConfirmEmailBase.errorMessage');

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

  final _$isLoadingAtom = Atom(name: '_WaitingConfirmEmailBase.isLoading');

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

  final _$isVerifyLoadingAtom =
      Atom(name: '_WaitingConfirmEmailBase.isVerifyLoading');

  @override
  bool get isVerifyLoading {
    _$isVerifyLoadingAtom.reportRead();
    return super.isVerifyLoading;
  }

  @override
  set isVerifyLoading(bool value) {
    _$isVerifyLoadingAtom.reportWrite(value, super.isVerifyLoading, () {
      super.isVerifyLoading = value;
    });
  }

  final _$verifyEmailAsyncAction =
      AsyncAction('_WaitingConfirmEmailBase.verifyEmail');

  @override
  Future verifyEmail(BuildContext context) {
    return _$verifyEmailAsyncAction.run(() => super.verifyEmail(context));
  }

  final _$sendToConfirmEmailAsyncAction =
      AsyncAction('_WaitingConfirmEmailBase.sendToConfirmEmail');

  @override
  Future sendToConfirmEmail(BuildContext context) {
    return _$sendToConfirmEmailAsyncAction
        .run(() => super.sendToConfirmEmail(context));
  }

  @override
  String toString() {
    return '''
hasError: ${hasError},
errorMessage: ${errorMessage},
isLoading: ${isLoading},
isVerifyLoading: ${isVerifyLoading}
    ''';
  }
}
