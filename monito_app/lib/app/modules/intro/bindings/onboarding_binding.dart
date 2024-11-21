import 'package:get/get.dart';
import 'package:monito/app/modules/intro/controller/onboarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());
  }
}