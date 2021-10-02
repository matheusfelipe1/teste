import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:joinder_app/app/shared/models/idAndLabel.dart';

import 'package:uuid/uuid.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:joinder_app/app/modules/authentication/signup/repositories/isignup_repository.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/custom_http/custom_http.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:joinder_app/app/shared/models/ways.dart';

class SignUpRepository implements ISignUpRepository {
  final _http = Modular.get<CustomHttp>();
  final _authController = Modular.get<AuthController>();

  final storageReference = FirebaseStorage.instance.ref();
  final referenceKey = "User";

  @override
  Future<List<String>> getCitiesSuggestions(String search) async {
    try {
      Response result = await Dio().get(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&language=pt_BR&components=country:br&key=AIzaSyBoRIqJtzmId_EH8FcxNOIPlx4iJq3iW_I");
      List<String> list = new List<String>();
      if (result.data['predictions'] != null &&
          result.data['predictions'] is List) {
        for (var item in result.data['predictions']) {
          final city = item['description'];
          if (city is String) list.add(city.replaceAll(", Brasil", ""));
        }
      }
      return list;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<String> getTermsOfUse() async {
    try {
      Response result = await _http.client.get('/contents/terms_of_use');
      if (result.data['results'] != null && result.data['results'] is String) {
        return jsonDecode(result.data['results']);
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  @override
  Future<String> getPrivacy() async {
    try {
      Response result = await _http.client.get('/contents/privacy');
      if (result.data['results'] != null && result.data['results'] is String) {
        return jsonDecode(result.data['results']);
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  @override
  Future<List<IdAndLabel>> getGoals() async {
    Response result = await _http.client.get('/contents/goals');
    List<IdAndLabel> listGoals = [];
    var resultData = result.data['results']['goals']['pt_BR'];
    if (resultData != null && resultData is List) {
      for (var item in resultData)
        if (item is Map) {
          String idItem = item.keys.first;
          listGoals.add(new IdAndLabel(id: idItem, label: item[idItem]));
        }
    }
    return listGoals;
  }

  @override
  Future<List<IdAndLabel>> getGenders() async {
    Response result = await _http.client.get('/contents/gender');
    List<IdAndLabel> listGenders = [];
    var resultData = result.data['results']['genders']['pt_BR'];
    if (resultData != null && resultData is List) {
      for (var item in resultData)
        if (item is Map) {
          String idItem = item.keys.first;
          listGenders.add(new IdAndLabel(id: idItem, label: item[idItem]));
        }
    }
    return listGenders;
  }

  @override
  Future<List<IdAndLabel>> getInterests() async {
    Response result = await _http.client.get('/contents/interests');
    List<IdAndLabel> listGenders = [];
    var resultData = result.data['results']['interests']['pt_BR'];
    if (resultData != null && resultData is List) {
      for (var item in resultData)
        if (item is Map) {
          String idItem = item.keys.first;
          listGenders.add(new IdAndLabel(id: idItem, label: item[idItem]));
        }
    }
    return listGenders;
  }

  @override
  Future<List<Ways>> getWayOfLoves() async {
    Response result = await _http.client.get('/contents/way_of_loves');
    List<Ways> way_of_loves = new List<Ways>();
    List resultData = result.data['results']['ways_of_love']['pt_BR'];
    if (resultData != null && resultData is List)
      for (var item in resultData)
        if (item is Map) {
          String idItem = item.keys.first;
          way_of_loves.add(new Ways(
            description: item[idItem]['description'],
            title: item[idItem]['title'],
            icon: getIconsToWayOfLove(idItem)[0],
            iconLight: getIconsToWayOfLove(idItem)[1],
            id: idItem,
          ));
        }
    return way_of_loves;
  }

  List<String> getIconsToWayOfLove(typeWayOfLove) {
    List<String> icons = ['', ''];
    switch (typeWayOfLove) {
      case 'affirming_words':
        icons[0] = 'assets/images/ic_palavras_roxo.png';
        icons[1] = 'assets/images/ic_palavras_cinza.png';
        break;
      case 'time':
        icons[0] = 'assets/images/ic_tempo_roxo.png';
        icons[1] = 'assets/images/ic_tempo_cinza.png';

        break;
      case 'gifts':
        icons[0] = 'assets/images/ic_presente_roxo.png';
        icons[1] = 'assets/images/ic_presente_cinza.png';
        break;
      case 'touch':
        icons[0] = 'assets/images/ic_toque_roxo.png';
        icons[1] = 'assets/images/ic_toque_cinza.png';
        break;
      case 'service':
        icons[0] = 'assets/images/ic_gestos_roxo.png';
        icons[1] = 'assets/images/ic_gestos_cinza.png';
        break;
      default:
        icons[0] = 'assets/images/ic_gestos_roxo.png';
        icons[1] = 'assets/images/ic_gestos_cinza.png';
        break;
    }
    return icons;
  }

  @override
  Future<int> verifyEmailExists(String email, context) async {
    try {
      Response result = await _http.client.get('/profiles/email?email=$email');
      return result.statusCode;
    } catch (e) {
      if (e != null && e.response != null && e.response.statusCode != null)
        return e.response.statusCode;
      throw e;
    }
  }

  @override
  Future<int> postProfile(Profile profile) async {
    try {
      final map = profile.toJson();
      Response result =
          await _http.client.post('/profiles', data: json.encode(map));
      return result.statusCode;
    } catch (e) {
      if (e != null && e.response != null && e.response.statusCode != null)
        return e.response.statusCode;
      throw e;
    }
  }

  @override
  Future<int> putProfile(Profile profile) async {
    try {
      final map = profile.toJson();
      Response result = await _http.client
          .put('/profiles/${profile.id}', data: json.encode(map));
      return result.statusCode;
    } catch (e) {
      if (e != null && e.response != null && e.response.statusCode != null)
        return e.response.statusCode;
      throw e;
    }
  }

  @override
  Future<int> deleteProfile(Profile profile, String reason) async {
    try {
      final map = {"reason": reason};
      Response result = await _http.client
          .delete('/profiles/${profile.id}', data: json.encode(map));
      return result.statusCode;
    } catch (e) {
      if (e != null && e.response != null && e.response.statusCode != null)
        return e.response.statusCode;
      throw e;
    }
  }

  @override
  Future<int> postConfigurationProfile(Profile profile) async {
    try {
      final map = profile.configuration.toJson();
      Response result = await _http.client.post(
          '/profiles/${profile.id}/configuration',
          data: json.encode(map));
      return result.statusCode;
    } catch (e) {
      if (e != null && e.response != null && e.response.statusCode != null)
        return e.response.statusCode;
      throw e;
    }
  }

  @override
  Future<int> patchProfileEmail(Profile profile, String email) async {
    try {
      Map<String, dynamic> finalMap = new Map<String, dynamic>();
      finalMap["email"] = email;

      Response result = await _http.client.patch(
          '/profiles/${profile.id}/new-identifier',
          data: json.encode(finalMap));
      return result.statusCode;
    } catch (e) {
      if (e != null && e.response != null && e.response.statusCode != null)
        return e.response.statusCode;
      throw e;
    }
  }

  @override
  Future<int> patchProfile(Profile profile, List<String> fields) async {
    try {
      final map = profile.toJson();
      Map<String, dynamic> finalMap = new Map<String, dynamic>();
      map.forEach((key, value) {
        if (fields.contains(key)) {
          finalMap[key] = value;
        }
      });

      Response result = await _http.client
          .patch('/profiles/${profile.id}', data: json.encode(finalMap));
      return result.statusCode;
    } catch (e) {
      if (e != null && e.response != null && e.response.statusCode != null)
        return e.response.statusCode;
      throw e;
    }
  }

  @override
  Future<int> sendFeedback(String message) async {
    try {
      final map = {"message": message};
      Response result =
          await _http.client.post('/users/feedback', data: json.encode(map));
      return result.statusCode;
    } catch (e) {
      if (e != null && e.response != null && e.response.statusCode != null)
        return e.response.statusCode;
      throw e;
    }
  }

  @override
  Future<String> uploadProfileImage(File file) async {
    try {
      String uidImg = Uuid().v1();
      final node = storageReference.child(referenceKey).child('$uidImg');
      StorageUploadTask uploadTask = node.putFile(file);
      await uploadTask.onComplete;
      return await node.getDownloadURL();
    } catch (e) {
      throw e;
    }
  }
}
