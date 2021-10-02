// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginBase, Store {
  final _$isLoadingAtom = Atom(name: '_LoginBase.isLoading');

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

  final _$facebookResultAtom = Atom(name: '_LoginBase.facebookResult');

  @override
  AuthStatus get facebookResult {
    _$facebookResultAtom.reportRead();
    return super.facebookResult;
  }

  @override
  set facebookResult(AuthStatus value) {
    _$facebookResultAtom.reportWrite(value, super.facebookResult, () {
      super.facebookResult = value;
    });
  }

  final _$doFacebookLoginAsyncAction =
      AsyncAction('_LoginBase.doFacebookLogin');

  @override
  Future doFacebookLogin(BuildContext context) {
    return _$doFacebookLoginAsyncAction
        .run(() => super.doFacebookLogin(context));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
facebookResult: ${facebookResult}
    ''';
  }
}
