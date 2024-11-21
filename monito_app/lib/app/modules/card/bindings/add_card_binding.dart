import 'package:get/get.dart';
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/data/providers/card_repository.dart';
import 'package:monito/app/modules/card/controllers/add_card_controller.dart';

class AddCardBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut(() => AuthRepository());
    }

    Get.lazyPut(() => CardRepository());

    Get.lazyPut(() => AddCardController());
  }
}
