import 'package:get/get.dart' show Get, GetxService, Inst;

import '../models/bank.dart';
import '../models/card.dart';
import '../services/pocketbase.dart';

class CardRepository extends GetxService {
  static CardRepository get instance => Get.find();

  final PocketBaseService _pocketBaseService = PocketBaseService.instance;
  static const String collectionName = 'cards';

  Future<List<Card>> getCardList() async {
    try {
      final result = await _pocketBaseService.getList(
        collectionName,
        expand: 'bank',
      );
      return result.items.map((item) => Card.fromRecord(item)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<Card> getCard(String cardId) async {
    try {
      final result = await _pocketBaseService.getOne(
        collectionName,
        id: cardId,
        expand: 'bank',
      );
      return Card.fromRecord(result);
    } catch (_) {
      rethrow;
    }
  }

  Future<Bank> getCardBank(String bankName) async {
    try {
      final result = await _pocketBaseService.getList(
        'banks',
        filter: 'name=\'$bankName\'',
      );
      return result.items.map((item) => Bank.fromRecord(item)).first;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> addCard(Map<String, dynamic> data) async {
    try {
      await _pocketBaseService.create(
        collectionName,
        data: data,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> editCard(String cardId, Map<String, dynamic> data) async {
    try {
      await _pocketBaseService.update(
        collectionName,
        id: cardId,
        data: data,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteCard(String cardId) async {
    try {
      await _pocketBaseService.delete(
        collectionName,
        id: cardId,
      );
    } catch (_) {
      rethrow;
    }
  }
}
