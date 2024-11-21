import 'package:flutter/material.dart' show Curves, PageController;
import 'package:get/get.dart' show Get, GetxController, Inst, IntExtension, RxInt, Trans;
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/gen/assets.gen.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  List<Map<String, dynamic>> onBoardingList = [
    {
      'image': Assets.svgs.onboarding1,
      'title': 'onboarding_title_1'.tr,
      'subTitle': 'onboarding_subtitle_1'.tr,
    },
    {
      'image': Assets.svgs.onboarding2,
      'title': 'onboarding_title_2'.tr,
      'subTitle': 'onboarding_subtitle_2'.tr,
    },
    {
      'image': Assets.svgs.onboarding3,
      'title': 'onboarding_title_3'.tr,
      'subTitle': 'onboarding_subtitle_3'.tr,
    },
  ];

  void changeCurrentPage(int page) => currentPage.value = page;

  void nextPage() {
    currentPage.value != onBoardingList.length - 1
        ? pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          )
        : Get.put(AuthRepository());
  }
}
