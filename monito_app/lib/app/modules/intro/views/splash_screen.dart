import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:get/get.dart' show Get, GetView, Obx, Trans;
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/widgets/app_button.dart';
import 'package:monito/gen/assets.gen.dart' show Assets;

import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.appColors.primary,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 78.r,
                    backgroundImage: Assets.images.splash.provider(),
                  )
                      .animate()
                      .fadeIn(
                        duration: 1500.ms,
                        curve: Curves.ease,
                        delay: 100.ms,
                      )
                      .slideY(
                        begin: .8,
                        end: 0,
                        duration: 600.ms,
                        curve: Curves.linear,
                      ),
                  20.verticalSpace,
                  Text(
                    'app_name'.tr,
                    style: Get.appTextTheme.titleExtraBold2.copyWith(
                      color: AppPalette.white,
                    ),
                  ).animate().fadeIn(delay: 500.ms).blurXY(
                        begin: 20,
                        end: 0,
                        duration: 800.ms,
                        delay: 500.ms,
                      ),
                ],
              ),
            ),
          ),
          Center(
            child: Obx(
              () => !controller.isConnected.value
                  ? Padding(
                      padding: 24.horizontal,
                      child: AppButton(
                        title: 'try_again'.tr,
                        isPrimary: false,
                        onPressed: () => controller.checkNetworkConnectivity(),
                      ),
                    )
                  : SizedBox(
                      width: 38.r,
                      height: 38.r,
                      child: CircularProgressIndicator(
                        color: AppPalette.white,
                        strokeWidth: 4.r,
                      ),
                    ),
            ),
          ),
          42.verticalSpace,
        ],
      ),
    );
  }
}
