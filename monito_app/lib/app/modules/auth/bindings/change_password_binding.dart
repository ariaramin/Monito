import 'package:get/get.dart' show Bindings, Get, Inst;

import '../controllers/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}
