import 'package:get/get.dart' show Bindings, Get, Inst;

import '../controllers/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
