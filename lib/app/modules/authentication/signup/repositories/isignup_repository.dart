import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:joinder_app/app/shared/models/idAndLabel.dart';
import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:joinder_app/app/shared/models/ways.dart';

abstract class ISignUpRepository {
  Future<List<String>> getCitiesSuggestions(String search) {}
  Future<String> getTermsOfUse();
  Future<String> getPrivacy();
  Future<List<IdAndLabel>> getGenders();
  Future<List<IdAndLabel>> getGoals();
  Future<List<IdAndLabel>> getInterests();
  Future<List<Ways>> getWayOfLoves();
  Future<int> postProfile(Profile profile);
  Future<int> putProfile(Profile profile);
  Future<int> deleteProfile(Profile profile, String reason);
  Future<int> postConfigurationProfile(Profile profile);
  Future<int> patchProfileEmail(Profile profile, String email);
  Future<int> patchProfile(Profile profile, List<String> fields);
  Future<int> verifyEmailExists(String email, BuildContext context);
  Future<int> sendFeedback(String message);
  Future<String> uploadProfileImage(File file);
}
