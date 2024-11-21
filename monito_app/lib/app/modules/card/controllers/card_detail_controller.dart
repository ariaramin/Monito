import 'package:get/get.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/models/card.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/data/models/transaction.dart';
import 'package:monito/app/data/providers/card_repository.dart';
import 'package:monito/app/data/providers/transaction_repository.dart';
import 'package:monito/app/modules/card/controllers/cards_controller.dart';
import 'package:monito/app/modules/transaction/controllers/home_controller.dart';
import 'package:monito/app/widgets/status_dialog.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show Jalali;

class CardDetailController extends GetxController {
  static CardDetailController get instance => Get.find();

  final CardRepository _cardRepository = CardRepository.instance;

  final TransactionRepository _transactionRepository =
      TransactionRepository.instance;

  Rx<Card> card = Card.empty.obs;

  Rx<bool> cardLoading = false.obs;

  RxMap<Jalali, List<Transaction>> transactionDateMap =
      <Jalali, List<Transaction>>{}.obs;

  RxList<Transaction> transactionList = <Transaction>[].obs;

  Rx<bool> transactionLoading = false.obs;

  RxList<Transaction> expenseList = <Transaction>[].obs;
  RxList<Transaction> incomeList = <Transaction>[].obs;

  RxString balance = '0'.obs;
  RxInt expenseAmount = 0.obs;
  RxInt incomeAmount = 0.obs;

  late final String cardId;

  @override
  void onInit() {
    // set dummy data to show loading
    transactionDateMap.value = {
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
    super.onInit();
  }

  @override
  void onReady() async {
    cardId = Get.arguments as String? ?? card.value.id;
    await Future.wait([getCard(), getTransactions()]);
    super.onReady();
  }

  Future<void> deleteCard() async {
    Get.back();
    try {
      await _cardRepository.deleteCard(cardId);

      // Refresh cards and transactions after deletion
      await Future.wait([
        CardsController.instance.getCards(),
        HomeController.instance.getTransactions(),
      ]);

      // Show success dialog
      Get.dialog(
        StatusDialog(
          message: 'delete_card_success'.tr,
          status: Status.success,
        ),
      );

      // Close overlays after a short delay if needed
      await Future.delayed(const Duration(seconds: 1));
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'delete_card_error'.tr).showDialog();
    } finally {
      Get.back(closeOverlays: true);
    }
  }

  Future<void> getCard() async {
    cardLoading.value = true;
    try {
      card.value = await _cardRepository.getCard(cardId);
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_card_error'.tr).showDialog();
    } finally {
      cardLoading.value = false;
    }
  }

  Future<void> getTransactions() async {
    transactionLoading.value = true;
    try {
      final transactions = await _transactionRepository.getTransactionList(
        filter: "card.id='$cardId'",
      );

      transactions.sort((a, b) => b.date.compareTo(a.date));

      transactionList.assignAll(transactions);

      // Convert transactions into a map and calculate balances
      _convertToTransactionMap(transactions);
      _calculateBalances();
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_transactions_error'.tr).showDialog();
    } finally {
      transactionLoading.value = false;
    }
  }

  void _convertToTransactionMap(List<Transaction> transactions) {
    transactionDateMap.clear();
    for (var transaction in transactions) {
      // Assuming transaction has a 'date' field
      final Jalali jalaliDate = transaction.date;

      // If the map already contains this date, add the transaction to the existing list
      if (transactionDateMap.containsKey(jalaliDate)) {
        transactionDateMap[jalaliDate]?.add(transaction);
      } else {
        // Otherwise, create a new list for this date
        transactionDateMap[jalaliDate] = [transaction];
      }
    }
    transactionDateMap.refresh();
  }

  void _calculateBalances() {
    int expenseTotal = 0;
    int incomeTotal = 0;
    final tempExpenseList = <Transaction>[];
    final tempIncomeList = <Transaction>[];

    for (var transaction in transactionList) {
      if (transaction.category.type == CategoryType.expense) {
        expenseTotal += transaction.amount;
        tempExpenseList.add(transaction);
      } else if (transaction.category.type == CategoryType.income) {
        incomeTotal += transaction.amount;
        tempIncomeList.add(transaction);
      }
    }

    // Assign all to reduce reactive updates
    expenseList.assignAll(tempExpenseList);
    incomeList.assignAll(tempIncomeList);

    // Update balances
    expenseAmount.value = expenseTotal;
    incomeAmount.value = incomeTotal;
    balance.value = (incomeTotal - expenseTotal).abs().toString();
  }
}
