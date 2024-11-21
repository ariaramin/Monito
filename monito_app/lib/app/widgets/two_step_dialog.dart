import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:get/get.dart' show Get, GetNavigation, Trans;
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/widgets/app_button.dart';

class TwoStepDialog extends StatelessWidget {
  const TwoStepDialog({
    super.key,
    required this.message,
    this.onConfirmPressed,
  });

  final String message;
  final Function()? onConfirmPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: 16.all,
        child: Container(
          padding: 18.vertical + 16.horizontal,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Get.appColors.background,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: Get.appTextTheme.regularBold2.copyWith(
                  fontFamily: 'IranSans',
                  color: Get.appColors.onBackground,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
              24.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'confirm'.tr,
                      color: Get.appColors.success,
                      onPressed: onConfirmPressed,
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: AppButton(
                      title: 'cancel'.tr,
                      color: Get.appColors.error,
                      isPrimary: false,
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
