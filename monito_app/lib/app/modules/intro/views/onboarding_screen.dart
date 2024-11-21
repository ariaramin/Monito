import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/modules/intro/controller/onboarding_controller.dart';
import 'package:monito/gen/assets.gen.dart';

import '../widgets/circle_progress_bar.dart';
part '../widgets/next_button.dart';
part '../widgets/onboarding.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics: const ClampingScrollPhysics(),
              onPageChanged: (int page) => controller.changeCurrentPage(page),
              children: controller.onBoardingList
                  .map(
                    (item) => OnBoarding(
                      image: item['image'],
                      title: item['title'],
                      subTitle: item['subTitle'],
                    ),
                  )
                  .toList(),
            ),
          ),
          const NextButton(),
          32.verticalSpace,
        ],
      ),
    );
  }
}
