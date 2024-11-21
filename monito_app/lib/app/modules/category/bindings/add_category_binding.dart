import 'package:get/get.dart' show Bindings, Get, Inst;

import '../controllers/add_category_controller.dart' show AddCategoryController;

class AddCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCategoryController());
  }
}
