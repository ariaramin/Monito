import 'package:get/get.dart'
    show
        BoolExtension,
        ExtensionDialog,
        Get,
        GetNavigation,
        GetxController,
        Inst,
        Rx,
        RxT,
        Trans;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/data/models/transaction.dart';
import 'package:monito/app/data/providers/category_repository.dart';
import 'package:monito/app/data/providers/transaction_repository.dart';
import 'package:monito/app/modules/category/controllers/categories_controller.dart';
import 'package:monito/app/modules/transaction/controllers/home_controller.dart';
import 'package:monito/app/widgets/status_dialog.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart' show Jalali;

class CategoryDetailController extends GetxController {
  static CategoryDetailController get instance => Get.find();

  final CategoryRepository _categoryRepository = CategoryRepository.instance;

  final TransactionRepository _transactionRepository =
      TransactionRepository.instance;

  RxMap<Jalali, List<Transaction>> transactionDateMap =
      <Jalali, List<Transaction>>{}.obs;

  RxList<Transaction> transactionList = <Transaction>[].obs;

  Rx<bool> transactionLoading = false.obs;

  Rx<Category> category = Category.empty.obs;

  Rx<bool> cardLoading = false.obs;

  RxString totalAmount = '0'.obs;

  late final String categoryId;

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
    categoryId = (Get.arguments as String? ?? category.value.id);
    await Future.wait([getCategory(), getTransactions()]);
    super.onReady();
  }

  Future<void> deleteCategory() async {
    Get.back();
    try {
      await _categoryRepository.deleteCategory(categoryId);

      // Refresh cards and transactions after deletion
      await Future.wait([
        CategoriesController.instance.getCategories(),
        HomeController.instance.getTransactions(),
      ]);

      // Show success dialog
      Get.dialog(
        StatusDialog(
          message: 'delete_category_success'.tr,
          status: Status.success,
        ),
      );

      // Close overlays after a short delay if needed
      await Future.delayed(const Duration(seconds: 1));
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'delete_category_error'.tr).showDialog();
    } finally {
      Get.back(closeOverlays: true);
    }
  }

  Future<void> getCategory() async {
    cardLoading.value = true;
    try {
      category.value = await _categoryRepository.getCategory(categoryId);
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_category_error'.tr).showDialog();
    } finally {
      cardLoading.value = false;
    }
  }

  Future<void> getTransactions() async {
    transactionLoading.value = true;
    try {
      final transactions = await _transactionRepository.getTransactionList(
        filter: "category.id='$categoryId'",
      );

      transactionList.assignAll(transactions);

      // Convert transactions into a map and calculate balances
      _convertToTransactionMap(transactions);
      _calculateTotalAmount();
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

  void _calculateTotalAmount() => totalAmount.value = transactionList
      .take(3)
      .fold(0, (sum, transaction) => sum + transaction.amount)
      .toString()
      .seRagham();
}
