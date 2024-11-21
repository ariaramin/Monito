import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:get/get.dart' show Get;
import 'package:monito/app/core/extensions/num_extension.dart'
    show SizedBoxExtension;
import 'package:monito/app/core/extensions/theme_extension.dart'
    show ThemeExtension;
import 'package:monito/app/core/extensions/widget_extension.dart'
    show TextExtension;
import 'package:persian_number_utility/persian_number_utility.dart'
    show StringExtensions;
import 'package:skeletonizer/skeletonizer.dart';

class OverviewInsideCard extends StatelessWidget {
  const OverviewInsideCard({
    super.key,
    required this.color,
    required this.title,
    required this.amount,
    this.hasBorder = false,
  });

  final Color color;
  final String title, amount;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Container(
        padding: 6.top + 8.horizontal,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: hasBorder
              ? Border.all(
                  width: 1.r,
                  color: Get.appColors.onBackground,
                  strokeAlign: BorderSide.strokeAlignOutside,
                )
              : null,
          color: Get.appColors.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton.keep(
              child: Text(
                title,
                style: Get.appTextTheme.smallBold3.copyWith(color: color),
              ),
            ),
            4.verticalSpace,
            Column(
              children: [
                Text(
                  amount.seRagham(),
                  style: Get.appTextTheme.titleBold1.copyWith(color: color),
                ).withToman(
                  style: Get.appTextTheme.smallBold1,
                ),
                Text(
                  amount.toWord(),
                  style: Get.appTextTheme.small1.copyWith(color: color),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                double.infinity.horizontalSpace,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
