import 'package:flutter/material.dart' show FormState, GlobalKey, Tab;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/core/extensions/getx_extension.dart';
import 'package:monito/app/data/models/card.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/data/models/transaction.dart';
import 'package:monito/app/data/providers/card_repository.dart';
import 'package:monito/app/data/providers/category_repository.dart';
import 'package:monito/app/data/providers/transaction_repository.dart';
import 'package:monito/app/widgets/app_bottom_sheet.dart';
import 'package:monito/app/widgets/status_dialog.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../widgets/card_list.dart';
import '../widgets/category_list.dart';
import 'card_picker_controller.dart';
import 'category_picker_controller.dart';

class ReportController extends GetxController
    implements CardPickerController, CategoryPickerController {
  final TransactionRepository _transactionRepository =
      TransactionRepository.instance;

  final CardRepository _cardRepository = CardRepository.instance;

  final CategoryRepository _categoryRepository = CategoryRepository.instance;

  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  RxList<Card> availableCards = <Card>[].obs;

  @override
  Rx<Card> selectedCard = Card.empty.obs;

  @override
  List<Tab> tabs = [
    Tab(text: 'expense'.tr),
    Tab(text: 'income'.tr),
  ];

  @override
  RxList<Category> expenseCategoryList = <Category>[].obs;

  @override
  RxList<Category> incomeCategoryList = <Category>[].obs;

  @override
  Rx<Category> selectedCategory = Category.empty.obs;

  Rx<Jalali> startDate = Jalali(
    Jalali.now().year,
    Jalali.now().month - 1, // One month ago
    Jalali.now().day,
  ).obs;

  RxMap<Jalali, List<Transaction>> transactionDateMap =
      <Jalali, List<Transaction>>{}.obs;

  RxList<Transaction> transactionList = <Transaction>[].obs;

  Rx<Jalali> endDate = Jalali.now().obs;

  Rx<bool> isLoading = false.obs;

  late String filter;

  @override
  void onInit() {
    // Set dummy data to show loading
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
    await getTransactions();
    super.onReady();
  }

  Future<void> getTransactions() async {
    isLoading.value = true;
    try {
      String formattedStartDate =
          DateFormat('yyyy-MM-dd').format(startDate.value.toDateTime());
      String formattedEndDate =
          DateFormat('yyyy-MM-dd').format(endDate.value.toDateTime());

      filter = "date>'$formattedStartDate'&&date<'$formattedEndDate'";

      if (selectedCard.value.id.isNotEmpty) {
        filter += "&&card.id='${selectedCard.value.id}'";
      }
      if (selectedCategory.value.id.isNotEmpty) {
        filter += "&&category.id='${selectedCategory.value.id}'";
      }

      final transactions = await _transactionRepository.getTransactionList(
        filter: filter,
      );

      transactions.sort((a, b) => b.date.compareTo(a.date));

      transactionList.assignAll(transactions);

      // Convert transactions into a map and calculate balances
      _convertToTransactionMap(transactions);
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_transactions_error'.tr).showDialog();
    } finally {
      isLoading.value = false;
    }
  }

  void resetFilter() async {
    selectedCard.value = Card.empty;
    selectedCategory.value = Category.empty;
    await getTransactions();
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

  void selectDateRange() async {
    final dateRange = await Get.showDateRangePicker(
      initialDateRange: JalaliRange(
        start: startDate.value,
        end: endDate.value,
      ),
    );
    if (dateRange != null) {
      startDate.value = dateRange.start;
      endDate.value = dateRange.end;
    }
  }

  @override
  void openCardPicker() async {
    if (availableCards.isEmpty) {
      await getCards();
      selectedCard.value = availableCards.first;
    }

    if (availableCards.isNotEmpty) {
      Get.bottomSheet(
        AppBottomSheet(
          child: CardList(controller: this),
        ),
      );
    } else {
      Get.dialog(StatusDialog(
        message: 'no_card_available'.tr,
        status: Status.error,
      ));
    }
  }

  @override
  Future<void> getCards() async {
    try {
      availableCards.value = await _cardRepository.getCardList();
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_cards_error'.tr).showDialog();
    }
  }

  @override
  void selectCard(int index) => selectedCard.value = availableCards[index];

  @override
  void openCategoryPicker() async {
    if (expenseCategoryList.isEmpty && incomeCategoryList.isEmpty) {
      await getCategories();
      selectedCategory.value = expenseCategoryList.first;
    }

    if (expenseCategoryList.isNotEmpty || incomeCategoryList.isNotEmpty) {
      Get.bottomSheet(
        AppBottomSheet(
          child: CategoryList(controller: this),
        ),
      );
    } else {
      Get.dialog(StatusDialog(
        message: 'no_category_available'.tr,
        status: Status.error,
      ));
    }
  }

  @override
  Future<void> getCategories() async {
    try {
      List<Category> categoryList = await _categoryRepository.getCategoryList();
      expenseCategoryList.value = categoryList
          .where((item) => item.type == CategoryType.expense)
          .toList();
      incomeCategoryList.value = categoryList
          .where((item) => item.type == CategoryType.income)
          .toList();
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_categories_error'.tr).showDialog();
    }
  }

  @override
  void selectCategory(Category category) => selectedCategory.value = category;
}
