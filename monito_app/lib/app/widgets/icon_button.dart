import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.h,
        height: 38.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Get.appColors.secondary,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 22.r,
            color: Get.appColors.onSecondary,
          ),
        ),
      ),
    );
  }
}
