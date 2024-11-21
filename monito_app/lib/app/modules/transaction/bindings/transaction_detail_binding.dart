import 'package:get/get.dart' show Bindings, Get, Inst;

import '../controllers/transaction_detail_controller.dart';

class TransactionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionDetailController());
  }
}
