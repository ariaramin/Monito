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
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/models/transaction.dart';
import 'package:monito/app/data/providers/transaction_repository.dart';
import 'package:monito/app/modules/transaction/controllers/transaction_list_controller.dart';
import 'package:monito/app/widgets/status_dialog.dart';

import 'home_controller.dart';

class TransactionDetailController extends GetxController {
  static TransactionDetailController get instance => Get.find();

  final TransactionRepository _transactionRepository =
      TransactionRepository.instance;

  Rx<Transaction> transaction = Transaction.empty.obs;

  Rx<bool> isLoading = false.obs;

  late final String transactionId;

  @override
  void onReady() async {
    transactionId = (Get.arguments as String? ?? transaction.value.id);
    await getTransaction();
    super.onReady();
  }

  Future<void> deleteTransaction() async {
    Get.back();
    try {
      await _transactionRepository.deleteTransaction(transactionId);

      // Refresh cards and transactions after deletion
      await HomeController.instance.getTransactions();
      if (Get.isRegistered<TransactionListController>()) {
        await TransactionListController.instance.getTransactions(isRefresh: true);
      }

      // Show success dialog
      Get.dialog(
        StatusDialog(
          message: 'delete_transaction_success'.tr,
          status: Status.success,
        ),
      );

      // Close overlays after a short delay if needed
      await Future.delayed(const Duration(seconds: 1));
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'delete_transaction_error'.tr).showDialog();
    } finally {
      Get.back(closeOverlays: true);
    }
  }

  Future<void> getTransaction() async {
    isLoading.value = true;
    try {
      transaction.value =
          await _transactionRepository.getTransaction(transactionId);
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_transaction_error'.tr).showDialog();
    } finally {
      isLoading.value = false;
    }
  }
}
