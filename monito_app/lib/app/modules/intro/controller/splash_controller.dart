import 'package:get/get.dart' show BoolExtension, Get, GetNavigation, GetxController, Inst, RxBool;
import 'package:is_first_run/is_first_run.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/data/services/network.dart';

class SplashController extends GetxController {
  final NetworkService _networkService = NetworkService.instance;

  RxBool isConnected = true.obs;

  @override
  void onReady() async {
    await Future.delayed(const Duration(milliseconds: 1600));
    checkNetworkConnectivity();
    super.onReady();
  }

  void checkNetworkConnectivity() async {
    isConnected.value = await _networkService.checkNetworkConnection();
    if (isConnected.value) {
      bool firstRun = await IsFirstRun.isFirstRun();
      firstRun
          ? Get.offAllNamed(AppRoutes.onboarding)
          : Get.put(AuthRepository());
    }
  }
}
