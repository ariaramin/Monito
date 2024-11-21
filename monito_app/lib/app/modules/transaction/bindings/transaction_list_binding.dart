import 'package:get/get.dart' show Bindings, Get, Inst;

import '../controllers/transaction_list_controller.dart';

class TransactionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionListController());
  }
}
