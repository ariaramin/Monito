import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/values/theme.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18.r),
        topRight: Radius.circular(18.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.r),
            topRight: Radius.circular(18.r),
          ),
          color: Get.appColors.background,
        ),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Padding(
              padding: 18.top + 16.bottom,
              child: child,
            ),
            Container(
              width: 36.w,
              height: 6.h,
              margin: 12.vertical,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                color: AppPalette.gray.withOpacity(.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
