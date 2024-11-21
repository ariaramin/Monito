import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/values/theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.isLoading = false,
    this.isPrimary = true,
    this.color,
    this.onPressed,
  });

  final String title;
  final bool isLoading;
  final bool isPrimary;
  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: !isPrimary
          ? TextButton.styleFrom(
              backgroundColor: Get.appColors.background,
              foregroundColor: color ?? Get.appColors.primary,
            )
          : TextButton.styleFrom(
              backgroundColor: color ?? Get.appColors.primary,
              foregroundColor: AppPalette.white,
            ),
      child: isLoading
          ? SizedBox(
              width: 24.r,
              height: 24.r,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Get.appColors.onPrimary,
              ),
            )
          : Text(title),
    );
  }
}
