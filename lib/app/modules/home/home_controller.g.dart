// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeBase, Store {
  final _$cardDetailAtom = Atom(name: '_HomeBase.cardDetail');

  @override
  CardModel get cardDetail {
    _$cardDetailAtom.reportRead();
    return super.cardDetail;
  }

  @override
  set cardDetail(CardModel value) {
    _$cardDetailAtom.reportWrite(value, super.cardDetail, () {
      super.cardDetail = value;
    });
  }

  final _$interestsAtom = Atom(name: '_HomeBase.interests');

  @override
  ObservableList<IdAndLabel> get interests {
    _$interestsAtom.reportRead();
    return super.interests;
  }

  @override
  set interests(ObservableList<IdAndLabel> value) {
    _$interestsAtom.reportWrite(value, super.interests, () {
      super.interests = value;
    });
  }

  final _$waysOfLoveAtom = Atom(name: '_HomeBase.waysOfLove');

  @override
  ObservableList<Ways> get waysOfLove {
    _$waysOfLoveAtom.reportRead();
    return super.waysOfLove;
  }

  @override
  set waysOfLove(ObservableList<Ways> value) {
    _$waysOfLoveAtom.reportWrite(value, super.waysOfLove, () {
      super.waysOfLove = value;
    });
  }

  final _$seeksAtom = Atom(name: '_HomeBase.seeks');

  @override
  ObservableList<IdAndLabel> get seeks {
    _$seeksAtom.reportRead();
    return super.seeks;
  }

  @override
  set seeks(ObservableList<IdAndLabel> value) {
    _$seeksAtom.reportWrite(value, super.seeks, () {
      super.seeks = value;
    });
  }

  final _$currentCardAtom = Atom(name: '_HomeBase.currentCard');

  @override
  CardModel get currentCard {
    _$currentCardAtom.reportRead();
    return super.currentCard;
  }

  @override
  set currentCard(CardModel value) {
    _$currentCardAtom.reportWrite(value, super.currentCard, () {
      super.currentCard = value;
    });
  }

  final _$counterAtom = Atom(name: '_HomeBase.counter');

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_HomeBase.isLoading');

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

  final _$isButtonDisabledAtom = Atom(name: '_HomeBase.isButtonDisabled');

  @override
  bool get isButtonDisabled {
    _$isButtonDisabledAtom.reportRead();
    return super.isButtonDisabled;
  }

  @override
  set isButtonDisabled(bool value) {
    _$isButtonDisabledAtom.reportWrite(value, super.isButtonDisabled, () {
      super.isButtonDisabled = value;
    });
  }

  final _$cardsAtom = Atom(name: '_HomeBase.cards');

  @override
  ObservableList<CardModel> get cards {
    _$cardsAtom.reportRead();
    return super.cards;
  }

  @override
  set cards(ObservableList<CardModel> value) {
    _$cardsAtom.reportWrite(value, super.cards, () {
      super.cards = value;
    });
  }

  final _$dequeuedCardsAtom = Atom(name: '_HomeBase.dequeuedCards');

  @override
  ObservableList<CardModel> get dequeuedCards {
    _$dequeuedCardsAtom.reportRead();
    return super.dequeuedCards;
  }

  @override
  set dequeuedCards(ObservableList<CardModel> value) {
    _$dequeuedCardsAtom.reportWrite(value, super.dequeuedCards, () {
      super.dequeuedCards = value;
    });
  }

  final _$interessesAtom = Atom(name: '_HomeBase.interesses');

  @override
  ObservableList<dynamic> get interesses {
    _$interessesAtom.reportRead();
    return super.interesses;
  }

  @override
  set interesses(ObservableList<dynamic> value) {
    _$interessesAtom.reportWrite(value, super.interesses, () {
      super.interesses = value;
    });
  }

  final _$photosAtom = Atom(name: '_HomeBase.photos');

  @override
  ObservableList<dynamic> get photos {
    _$photosAtom.reportRead();
    return super.photos;
  }

  @override
  set photos(ObservableList<dynamic> value) {
    _$photosAtom.reportWrite(value, super.photos, () {
      super.photos = value;
    });
  }

  final _$fillCardProfileAsyncAction = AsyncAction('_HomeBase.fillCardProfile');

  @override
  Future<CardModel> fillCardProfile(CardModel card) {
    return _$fillCardProfileAsyncAction.run(() => super.fillCardProfile(card));
  }

  final _$reportUserAsyncAction = AsyncAction('_HomeBase.reportUser');

  @override
  Future reportUser(BuildContext context, String desc, CardModel card) {
    return _$reportUserAsyncAction
        .run(() => super.reportUser(context, desc, card));
  }

  final _$addToFridgeAsyncAction = AsyncAction('_HomeBase.addToFridge');

  @override
  Future addToFridge(BuildContext context, String desc, CardModel card) {
    return _$addToFridgeAsyncAction
        .run(() => super.addToFridge(context, desc, card));
  }

  final _$_HomeBaseActionController = ActionController(name: '_HomeBase');

  @override
  dynamic fillCards(dynamic previous, dynamic next) {
    final _$actionInfo =
        _$_HomeBaseActionController.startAction(name: '_HomeBase.fillCards');
    try {
      return super.fillCards(previous, next);
    } finally {
      _$_HomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeCard(CardModel card) {
    final _$actionInfo =
        _$_HomeBaseActionController.startAction(name: '_HomeBase.removeCard');
    try {
      return super.removeCard(card);
    } finally {
      _$_HomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic backCard() {
    final _$actionInfo =
        _$_HomeBaseActionController.startAction(name: '_HomeBase.backCard');
    try {
      return super.backCard();
    } finally {
      _$_HomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cardDetail: ${cardDetail},
interests: ${interests},
waysOfLove: ${waysOfLove},
seeks: ${seeks},
currentCard: ${currentCard},
counter: ${counter},
isLoading: ${isLoading},
isButtonDisabled: ${isButtonDisabled},
cards: ${cards},
dequeuedCards: ${dequeuedCards},
interesses: ${interesses},
photos: ${photos}
    ''';
  }
}
