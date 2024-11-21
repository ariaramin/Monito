import 'package:get/get.dart' show Bindings, Get, Inst;

import '../controllers/edit_transaction_controller.dart';

class EditTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditTransactionController());
  }
}
