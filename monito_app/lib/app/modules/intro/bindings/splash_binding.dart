import 'package:get/get.dart';
import 'package:monito/app/data/services/network.dart';
import 'package:monito/app/modules/intro/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkService());

    Get.lazyPut(() => SplashController());
  }
}
