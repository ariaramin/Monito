import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/models/transaction.dart';
import 'package:monito/app/data/providers/transaction_repository.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show Jalali;

class TransactionListController extends GetxController {
  static TransactionListController get instance => Get.find();

  final TransactionRepository _transactionRepository =
      TransactionRepository.instance;

  RxMap<Jalali, List<Transaction>> transactionsByDate =
      <Jalali, List<Transaction>>{}.obs;

  final ScrollController scrollController = ScrollController();

  int _currentPage = 1;
  final int _perPage = 30;
  bool hasMore = true;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    _createDummyData();
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onReady() async {
    await getTransactions();
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getTransactions();
    }
  }

  void _createDummyData() {
    // Set dummy data to show loading
    transactionsByDate.value = {
      Jalali.now(): [
        Transaction.empty,
        Transaction.empty,
      ],
      Jalali.now().addDays(1): [
        Transaction.empty,
        Transaction.empty,
      ],
      Jalali.now().addDays(2): [
        Transaction.empty,
        Transaction.empty,
      ]
    };
  }

  Future<void> getTransactions({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      hasMore = true;
      _createDummyData();
    }

    if (!hasMore) return;

    isLoading.value = true;

    try {
      String? filter = Get.arguments as String?;

      final transactions = await _transactionRepository.getTransactionList(
        page: _currentPage,
        perPage: _perPage,
        filter: filter,
      );

      // If the fetched data is less than the per page limit, there is no more data
      hasMore = transactions.length == _perPage;
      if (hasMore) _currentPage++;

      transactions.sort((a, b) => b.date.compareTo(a.date));

      // Clear dummy data
      if (transactionsByDate.length <= 3) {
        transactionsByDate.clear();
      }
      _convertToTransactionMap(transactions);
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_transactions_error'.tr).showDialog();
    } finally {
      isLoading.value = false;
    }
  }

  void _convertToTransactionMap(List<Transaction> transactions) {
    for (var transaction in transactions) {
      // Assuming transaction has a 'date' field
      final Jalali jalaliDate = transaction.date;

      // If the map already contains this date, add the transaction to the existing list
      if (transactionsByDate.containsKey(jalaliDate)) {
        transactionsByDate[jalaliDate]?.add(transaction);
      } else {
        // Otherwise, create a new list for this date
        transactionsByDate[jalaliDate] = [transaction];
      }
    }
    transactionsByDate.refresh();
  }
}
