import 'package:flutter/material.dart'
    show FormState, GlobalKey, Tab, TextEditingController;
import 'package:get/get.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/core/extensions/getx_extension.dart';
import 'package:monito/app/data/models/card.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/data/models/transaction.dart';
import 'package:monito/app/data/providers/card_repository.dart';
import 'package:monito/app/data/providers/category_repository.dart';
import 'package:monito/app/data/providers/transaction_repository.dart';
import 'package:monito/app/modules/transaction/controllers/transaction_detail_controller.dart';
import 'package:monito/app/widgets/app_bottom_sheet.dart';
import 'package:monito/app/widgets/status_dialog.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show Jalali;

import '../widgets/card_list.dart';
import '../widgets/category_list.dart';
import 'card_picker_controller.dart';
import 'category_picker_controller.dart';
import 'home_controller.dart';
import 'transaction_list_controller.dart';

class EditTransactionController extends GetxController
    implements CardPickerController, CategoryPickerController {
  final TransactionRepository _transactionRepository =
      TransactionRepository.instance;

  final CardRepository _cardRepository = CardRepository.instance;

  final CategoryRepository _categoryRepository = CategoryRepository.instance;

// form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

// text field controllers
  final TextEditingController description = TextEditingController();
  final TextEditingController amount = TextEditingController();

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

  Rx<Jalali> selectedDate = Jalali.now().obs;

  Rx<bool> isLoading = false.obs;

  late final Transaction transaction;

  @override
  void onInit() {
    transaction = Get.arguments as Transaction;

    // Set initial values
    description.text = transaction.description;
    amount.text = transaction.amount.toString();
    selectedCategory.value = transaction.category;
    selectedCard.value = transaction.card;
    selectedDate.value = transaction.date;

    super.onInit();
  }

  @override
  void onClose() {
    description.dispose();
    amount.dispose();
    super.onClose();
  }

  Future<void> editTransaction() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await _transactionRepository.editTransaction(transaction.id, {
          "user": transaction.user,
          "description": description.text.trim(),
          "amount": int.parse(amount.text.trim().replaceAll(',', '')),
          "category": selectedCategory.value.id,
          "card": selectedCard.value.id,
          "date": selectedDate.value.toDateTime().toIso8601String(),
        });
        Get.dialog(StatusDialog(
          message: 'edit_transaction_success'.tr,
          status: Status.success,
        ));
        HomeController.instance.getTransactions();
        TransactionDetailController.instance.getTransaction();
        if (Get.isRegistered<TransactionListController>()) {
          await TransactionListController.instance
              .getTransactions(isRefresh: true);
        }
        await Future.delayed(const Duration(seconds: 1));
        Get.back(closeOverlays: true);
      } on ApiException catch (exception) {
        Failure(message: exception.message).showDialog();
      } catch (e) {
        Failure(message: 'edit_transaction_error'.tr).showDialog();
      } finally {
        isLoading.value = false;
      }
    }
  }

  void selectDate() async {
    final date = await Get.showDatePicker(initialDate: selectedDate.value);
    if (date != null) {
      selectedDate.value = date;
    }
  }

  @override
  void openCardPicker() async {
    if (availableCards.isEmpty) {
      await getCards();
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
