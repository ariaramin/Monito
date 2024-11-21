import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/data/models/transaction.dart';
import 'package:monito/app/data/providers/transaction_repository.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final TransactionRepository _transactionRepository =
      TransactionRepository.instance;

  late final PageController chartPageController;

  RxList<Transaction> transactionList = <Transaction>[].obs;
  RxBool isLoading = false.obs;

  RxBool isShowingBalance = true.obs;

  RxList<Transaction> expenseList = <Transaction>[].obs;
  RxList<Transaction> incomeList = <Transaction>[].obs;

  RxString balance = '0'.obs;
  RxInt expenseAmount = 0.obs;
  RxInt incomeAmount = 0.obs;

  @override
  void onInit() {
    transactionList.value = List.generate(6, (index) => Transaction.empty);
    chartPageController = PageController();
    super.onInit();
  }

  @override
  void onReady() async {
    await getTransactions();
    super.onReady();
  }

  @override
  void onClose() {
    chartPageController.dispose();
    super.onClose();
  }

  void toggleCardContent() => isShowingBalance.toggle();

  Future<void> getTransactions() async {
    isLoading.value = true;
    try {
      final transactions = await _transactionRepository.getTransactionList();
      transactions.sort((a, b) => b.date.compareTo(a.date));
      transactionList.value = transactions;
      _calculateBalances();
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_transactions_error'.tr).showDialog();
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateBalances() {
    int expenseTotal = 0;
    int incomeTotal = 0;

    for (var transaction in transactionList) {
      if (transaction.category.type == CategoryType.expense) {
        expenseTotal += transaction.amount;
        expenseList.add(transaction);
      } else if (transaction.category.type == CategoryType.income) {
        incomeTotal += transaction.amount;
        incomeList.add(transaction);
      }
    }

    expenseAmount.value = expenseTotal;
    incomeAmount.value = incomeTotal;
    balance.value = (incomeTotal - expenseTotal).abs().toString().seRagham();
  }
}
