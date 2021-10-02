// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthBase, Store {
  final _$currentUserAtom = Atom(name: '_AuthBase.currentUser');

  @override
  FirebaseUser get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(FirebaseUser value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  final _$statusAtom = Atom(name: '_AuthBase.status');

  @override
  AuthStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AuthStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$typeAtom = Atom(name: '_AuthBase.type');

  @override
  AuthType get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(AuthType value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  final _$facebookProfileAtom = Atom(name: '_AuthBase.facebookProfile');

  @override
  FacebookProfile get facebookProfile {
    _$facebookProfileAtom.reportRead();
    return super.facebookProfile;
  }

  @override
  set facebookProfile(FacebookProfile value) {
    _$facebookProfileAtom.reportWrite(value, super.facebookProfile, () {
      super.facebookProfile = value;
    });
  }

  final _$profileAtom = Atom(name: '_AuthBase.profile');

  @override
  Profile get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(Profile value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  final _$isEmailActivatedAtom = Atom(name: '_AuthBase.isEmailActivated');

  @override
  bool get isEmailActivated {
    _$isEmailActivatedAtom.reportRead();
    return super.isEmailActivated;
  }

  @override
  set isEmailActivated(bool value) {
    _$isEmailActivatedAtom.reportWrite(value, super.isEmailActivated, () {
      super.isEmailActivated = value;
    });
  }

  final _$locationAtom = Atom(name: '_AuthBase.location');

  @override
  Location get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(Location value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  final _$_permissionGrantedAtom = Atom(name: '_AuthBase._permissionGranted');

  @override
  PermissionStatus get _permissionGranted {
    _$_permissionGrantedAtom.reportRead();
    return super._permissionGranted;
  }

  @override
  set _permissionGranted(PermissionStatus value) {
    _$_permissionGrantedAtom.reportWrite(value, super._permissionGranted, () {
      super._permissionGranted = value;
    });
  }

  final _$locationDataAtom = Atom(name: '_AuthBase.locationData');

  @override
  LocationData get locationData {
    _$locationDataAtom.reportRead();
    return super.locationData;
  }

  @override
  set locationData(LocationData value) {
    _$locationDataAtom.reportWrite(value, super.locationData, () {
      super.locationData = value;
    });
  }

  final _$currentChatAtom = Atom(name: '_AuthBase.currentChat');

  @override
  String get currentChat {
    _$currentChatAtom.reportRead();
    return super.currentChat;
  }

  @override
  set currentChat(String value) {
    _$currentChatAtom.reportWrite(value, super.currentChat, () {
      super.currentChat = value;
    });
  }

  final _$doFacebookLoginAsyncAction = AsyncAction('_AuthBase.doFacebookLogin');

  @override
  Future<FacebookProfile> doFacebookLogin() {
    return _$doFacebookLoginAsyncAction.run(() => super.doFacebookLogin());
  }

  final _$signInWithCredentialAsyncAction =
      AsyncAction('_AuthBase.signInWithCredential');

  @override
  Future<bool> signInWithCredential(
      AuthCredential credential, AuthType selectionType) {
    return _$signInWithCredentialAsyncAction
        .run(() => super.signInWithCredential(credential, selectionType));
  }

  final _$createUserWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthBase.createUserWithEmailAndPassword');

  @override
  Future<bool> createUserWithEmailAndPassword(
      String email, String password, BuildContext context) {
    return _$createUserWithEmailAndPasswordAsyncAction.run(
        () => super.createUserWithEmailAndPassword(email, password, context));
  }

  final _$signInWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthBase.signInWithEmailAndPassword');

  @override
  Future<bool> signInWithEmailAndPassword(
      String email, String password, BuildContext context) {
    return _$signInWithEmailAndPasswordAsyncAction
        .run(() => super.signInWithEmailAndPassword(email, password, context));
  }

  final _$sendPasswordResetEmailAsyncAction =
      AsyncAction('_AuthBase.sendPasswordResetEmail');

  @override
  Future<bool> sendPasswordResetEmail(String email, BuildContext context) {
    return _$sendPasswordResetEmailAsyncAction
        .run(() => super.sendPasswordResetEmail(email, context));
  }

  final _$geoLocationAsyncAction = AsyncAction('_AuthBase.geoLocation');

  @override
  Future geoLocation() {
    return _$geoLocationAsyncAction.run(() => super.geoLocation());
  }

  final _$getTokenAsyncAction = AsyncAction('_AuthBase.getToken');

  @override
  Future<String> getToken() {
    return _$getTokenAsyncAction.run(() => super.getToken());
  }

  final _$signOutAsyncAction = AsyncAction('_AuthBase.signOut');

  @override
  Future signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$onAuthStatusAsyncAction = AsyncAction('_AuthBase.onAuthStatus');

  @override
  Future onAuthStatus() {
    return _$onAuthStatusAsyncAction.run(() => super.onAuthStatus());
  }

  final _$_AuthBaseActionController = ActionController(name: '_AuthBase');

  @override
  dynamic doPhoneAuthentication(
      String phoneNumber,
      dynamic Function(AuthCredential) verificationCompleted,
      dynamic Function(AuthException) verificationFailed,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout) {
    final _$actionInfo = _$_AuthBaseActionController.startAction(
        name: '_AuthBase.doPhoneAuthentication');
    try {
      return super.doPhoneAuthentication(phoneNumber, verificationCompleted,
          verificationFailed, codeSent, codeAutoRetrievalTimeout);
    } finally {
      _$_AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onStateChanged() {
    final _$actionInfo = _$_AuthBaseActionController.startAction(
        name: '_AuthBase.onStateChanged');
    try {
      return super.onStateChanged();
    } finally {
      _$_AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showSnackbar(
      BuildContext context, String typeSnackBar, String message) {
    final _$actionInfo =
        _$_AuthBaseActionController.startAction(name: '_AuthBase.showSnackbar');
    try {
      return super.showSnackbar(context, typeSnackBar, message);
    } finally {
      _$_AuthBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
status: ${status},
type: ${type},
facebookProfile: ${facebookProfile},
profile: ${profile},
isEmailActivated: ${isEmailActivated},
location: ${location},
locationData: ${locationData},
currentChat: ${currentChat}
    ''';
  }
}
