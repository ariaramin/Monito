import 'package:get/get.dart' show Bindings, Get, Inst;
import 'package:monito/app/modules/card/controllers/edit_card_controller.dart' show EditCardController;

class EditCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditCardController());
  }
}
