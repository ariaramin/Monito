import 'package:get/get.dart' show Bindings, Get, Inst;

import '../controllers/add_transaction_controller.dart';

class AddTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTransactionController());
  }
}
