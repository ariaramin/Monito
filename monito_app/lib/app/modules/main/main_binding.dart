import 'package:get/get.dart' show Bindings, Get, Inst;
import 'package:monito/app/data/providers/card_repository.dart';
import 'package:monito/app/data/providers/category_repository.dart';
import 'package:monito/app/data/providers/transaction_repository.dart';
import 'package:monito/app/modules/auth/controllers/profile_controller.dart';
import 'package:monito/app/modules/card/controllers/cards_controller.dart';
import 'package:monito/app/modules/category/controllers/categories_controller.dart';
import 'package:monito/app/modules/main/bottom_navigation_controller.dart';
import 'package:monito/app/modules/transaction/controllers/home_controller.dart';
import 'package:monito/app/modules/transaction/controllers/report_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationController());

    Get.lazyPut(() => HomeController());

    Get.lazyPut(() => TransactionRepository());

    Get.lazyPut(() => CardRepository());

    Get.lazyPut(() => CardsController());

    Get.lazyPut(() => CategoryRepository());

    Get.lazyPut(() => CategoriesController());

    Get.lazyPut(() => ProfileController());

    Get.lazyPut(() => ReportController());
  }
}
