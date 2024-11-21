import 'package:get/get.dart' show Bindings, Get, Inst;
import 'package:monito/app/modules/category/controllers/edit_category_controller.dart';

class EditCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditCategoryController());
  }
}
