import 'package:joinder_app/app/shared/models/card_model.dart';

abstract class IHomeRepository {
  Future<List<CardModel>> getCards(bool previous, bool next);
  Future<CardModel> getCard(String id);
}
