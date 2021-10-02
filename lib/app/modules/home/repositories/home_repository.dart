import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:joinder_app/app/modules/home/home_controller.dart';
import 'package:joinder_app/app/shared/models/card_model.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

import 'package:joinder_app/app/modules/home/repositories/ihome_repository.dart';

import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/custom_http/custom_http.dart';

class HomeRepository implements IHomeRepository {
  String urlNext = null;
  String urlPrevious = null;

  final _http = Modular.get<CustomHttp>();
  final _authController = Modular.get<AuthController>();

  @override
  Future<List<CardModel>> getCards(bool previous, bool next) async {
    var now = new DateTime.now();
    List<CardModel> listCards = [];
    try {
      var profile = _authController.profile;
      var url = "";
      if (previous && urlPrevious != null) {
        url = urlPrevious.replaceAll("/api/v1", "");
      } else if (next && urlNext != null) {
        url = urlNext.replaceAll("/api/v1", "");
      } else {
        url = '/lovers/?start=1&limit=5';
      }

      if (url == "" || url == null) {
        return listCards = [];
      }

      Response result = await _http.client.get(url + "&cache=${now}");
      var resultData = result.data['results'];
      urlPrevious = result.data['previous'];
      urlNext = result.data['next'];
      if (resultData != null && resultData is List) {
        for (var item in resultData)
          if (item is Map) {
            CardModel card = CardModel.fromJson(item);
            card.type = CardType.profile;
            listCards.add(card);
          }
      }
      return listCards;
    } catch (e) {
      return listCards = [];
    }
  }

  @override
  Future<CardModel> getCard(String id) async {
    try {
      final result = await _http.client.get('/lovers/details/?match_id=${id}');
      var resultData = result.data['results'];
      if (resultData is Map) {
        CardModel card = new CardModel.fromJson(resultData);
        card.type = CardType.profile;
        return card;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
