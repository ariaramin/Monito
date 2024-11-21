import 'package:get/get.dart' show Get, GetxService, Inst;

import '../models/transaction.dart';
import '../services/pocketbase.dart';

class TransactionRepository extends GetxService {
  static TransactionRepository get instance => Get.find();

  final PocketBaseService _pocketBaseService = PocketBaseService.instance;
  static const String collectionName = 'transactions';

  Future<List<Transaction>> getTransactionList({
    int page = 1,
    int perPage = 30,
    String? filter,
  }) async {
    try {
      final result = await _pocketBaseService.getList(
        collectionName,
        page: page,
        perPage: perPage,
        expand: 'category.icon,card.bank',
        sort: '-created',
        filter: filter,
      );
      return result.items.map((item) => Transaction.fromRecord(item)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<Transaction> getTransaction(String transactionId) async {
    try {
      final result = await _pocketBaseService.getOne(
        collectionName,
        id: transactionId,
        expand: 'category.icon,card.bank',
      );
      return Transaction.fromRecord(result);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> addTransaction(Map<String, dynamic> data) async {
    try {
      await _pocketBaseService.create(
        collectionName,
        data: data,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> editTransaction(
    String transactionId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _pocketBaseService.update(
        collectionName,
        id: transactionId,
        data: data,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      await _pocketBaseService.delete(
        collectionName,
        id: transactionId,
      );
    } catch (_) {
      rethrow;
    }
  }
}
