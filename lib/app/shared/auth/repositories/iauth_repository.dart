import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:joinder_app/app/shared/models/facebook_profile.dart';
import 'package:joinder_app/app/shared/models/profile.dart';

abstract class IAuthRepository {
  Future<FacebookProfile> signInWithFacebook();
  Future<FirebaseUser> signInWithCredential(AuthCredential credential);
  Future<void> sendPasswordResetEmail(String email, BuildContext context);
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password);
  Future<FirebaseUser> createUserWithEmailAndPassword(
      String email, String password);
  void verifyPhoneNumber(
      String phoneNumber,
      Function(AuthCredential) verificationCompleted,
      Function(AuthException) verificationFailed,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout);
  Future<FirebaseUser> getFirebaseUser();
  Future<bool> sendToConfirmEmail();
  Future<Profile> getUserProfile();
  Future<bool> getUserStatus();
  void registerDeviceToken(String token, String userId);
  Future<String> getToken();
  Future<void> signOut();
}
