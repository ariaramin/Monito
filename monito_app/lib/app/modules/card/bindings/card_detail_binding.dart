import 'package:get/get.dart' show Bindings, Get, Inst;

import '../controllers/card_detail_controller.dart';

class CardDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CardDetailController());
  }
}
