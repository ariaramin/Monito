import 'package:get/get.dart' show Bindings, Get, Inst;
import 'package:monito/app/modules/category/controllers/category_detail_controller.dart';

class CategoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDetailController());
  }
}
