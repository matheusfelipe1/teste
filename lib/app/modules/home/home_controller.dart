import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:joinder_app/app/modules/authentication/signup/repositories/isignup_repository.dart';
import 'package:joinder_app/app/modules/chat/chat_controller.dart';
import 'package:joinder_app/app/modules/chat/repositories/ichat_repository.dart';
import 'package:joinder_app/app/modules/home/repositories/ihome_repository.dart';
import 'package:joinder_app/app/shared/auth/auth_controller.dart';
import 'package:joinder_app/app/shared/models/idAndLabel.dart';
import 'package:joinder_app/app/shared/models/profile.dart';
import 'package:joinder_app/app/shared/models/ways.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';
import 'package:mobx/mobx.dart';

import 'package:joinder_app/app/shared/models/card_model.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final IHomeRepository _homeRepository = Modular.get();
  final _authController = Modular.get<AuthController>();
  final ISignUpRepository _signUpRepository = Modular.get();
  final IChatRepository _chatRepository = Modular.get();

  @observable
  CardModel cardDetail;

  @observable
  ObservableList<IdAndLabel> interests;

  @observable
  ObservableList<Ways> waysOfLove;

  @observable
  ObservableList<IdAndLabel> seeks;

  @observable
  CardModel currentCard = new CardModel(
      age: 0,
      content: '',
      id: '',
      //image: '',
      name: '',
      sign: '',
      type: CardType.profile,
      percent: 0,
      city: '',
      state: '',
      distance: 0,
      waysOfLove: [],
      goals: [],
      interestedIn: [],
      lookingFor: [],
      photos: []);

  @observable
  int counter = 1;

  @observable
  bool isLoading = false;

  @observable
  bool isButtonDisabled = false;

  @observable
  ObservableList<CardModel> cards = new ObservableList<CardModel>();

  @observable
  ObservableList<CardModel> dequeuedCards = new ObservableList<CardModel>();

  @observable
  ObservableList interesses = new ObservableList();

  @observable
  ObservableList photos = new ObservableList();

  _HomeBase() {
    _init();
  }

  _init() {
    fillCards(false, false);
  }

  @action
  fillCards(previous, next) {
    isLoading = true;
    Timer(Duration(seconds: 3), () async {
      cards.clear();
      cards = ObservableList<CardModel>.of(
          await _homeRepository.getCards(previous, next));

      if (cards.length > 0) {
        currentCard = cards.first;
      } else {
        currentCard = new CardModel(
            age: 0,
            content: '',
            id: '',
            //image: '',
            name: '',
            sign: '',
            type: CardType.profile,
            percent: 0,
            city: '',
            state: '',
            distance: 0,
            waysOfLove: [],
            goals: [],
            interestedIn: [],
            lookingFor: [],
            photos: []);
      }
      isLoading = false;
    });
  }

  @action
  removeCard(CardModel card) {
    if (cards.length > 0) {
      cards.removeWhere((c) => c.id == card.id);
      dequeuedCards.add(new CardModel(
          age: card.age,
          content: card.content,
          id: card.id,
          // image: card.image,
          name: card.name,
          sign: card.sign,
          type: card.type,
          percent: card.percent,
          city: card.city,
          state: card.state,
          distance: card.distance,
          waysOfLove: card.waysOfLove,
          goals: card.goals,
          interestedIn: card.interestedIn,
          lookingFor: card.lookingFor,
          photos: card.photos));
    }
  }

  @action
  backCard() {
    if (dequeuedCards.length > 0) {
      isLoading = true;
      var temp = new ObservableList<CardModel>();
      for (var card in cards) {
        temp.add(new CardModel(
            age: card.age,
            content: card.content,
            id: card.id,
            //image: card.image,
            name: card.name,
            sign: card.sign,
            type: card.type,
            percent: card.percent,
            state: card.state,
            city: card.city,
            distance: card.distance,
            waysOfLove: card.waysOfLove,
            goals: card.goals,
            interestedIn: card.interestedIn,
            lookingFor: card.lookingFor,
            photos: card.photos));
      }
      cards.clear();
      Timer(Duration(milliseconds: 500), () {
        cards = temp;
        cards.insert(
            0,
            new CardModel(
                age: dequeuedCards.last.age,
                content: dequeuedCards.last.content,
                id: dequeuedCards.last.id,
                // image: dequeuedCards.last.image,
                name: dequeuedCards.last.name,
                sign: dequeuedCards.last.sign,
                type: dequeuedCards.last.type,
                percent: dequeuedCards.last.percent,
                distance: dequeuedCards.last.distance,
                city: dequeuedCards.last.city,
                state: dequeuedCards.last.state,
                waysOfLove: dequeuedCards.last.waysOfLove,
                goals: dequeuedCards.last.goals,
                interestedIn: dequeuedCards.last.interestedIn,
                lookingFor: dequeuedCards.last.lookingFor,
                photos: dequeuedCards.last.photos));
        dequeuedCards.removeLast();
        currentCard = cards.first;
        isLoading = false;
      });
    }
  }

  @action
  Future<CardModel> fillCardProfile(CardModel card) async {
    if (waysOfLove == null) {
      waysOfLove = ObservableList.of(await _signUpRepository.getWayOfLoves());
    }
    if (seeks == null) {
      seeks = ObservableList.of(await _signUpRepository.getGoals());
    }
    if (interests == null) {
      interests = ObservableList.of(await _signUpRepository.getInterests());
    }
    cardDetail = new CardModel();
    cardDetail = card;
    Modular.to.pushNamed('home/profile-detail');
  }

  @action
  reportUser(BuildContext context, String desc, CardModel card) async {
    final result =
        await _chatRepository.reportUser(card.id, 'REPORT', desc);
    switch (result) {
      case 200:
        await AppUtils.defaultDialogChat(
          context,
          "VOCÊ ACABA DE FAZER\n UMA DENÚNCIA",
          "DENUNCIAR",
          true,
          false,
          'assets/images/ic_denunciar_topo.png',
          'Agradecemos pela sua atitude. \nQueremos que você sinta\n segurança e acolhimento.',
          true,
          buttonText: "OK",
        );
        break;
      default:
        _authController.showSnackbar(
            context, 'error', 'Ups... \n Erro ao reportar esse usuário :(');
        break;
    }
  }

  @action
  addToFridge(BuildContext context, String desc, CardModel card) async {
    await _chatRepository.addToFridge(card.id);
    fillCards(false, false);
    _chatRepository.reportUser(card.id, 'FREEZE', desc);

    await AppUtils.defaultDialogChat(
      context,
      "OK. VOCÊ ACABA DE DAR\n UM GELO EM",
      card.name,
      true,
      true,
      'assets/images/ice.png',
      'O usuário ficará na geladeira \ndurante o tempo que você achar \nnecessário!',
      true,
      buttonText: "OK",
    );
    if(context.widget.toString() != 'HomePage'){
      Modular.to.pop();
    }
  }
}
