import 'package:flutter/material.dart' show BuildContext, Expanded, Row, StatelessWidget, Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:get/get.dart' show Get, Trans;
import 'package:monito/app/core/extensions/theme_extension.dart' show ThemeExtension;
import 'package:monito/app/widgets/inside_card.dart' show OverviewInsideCard;
import 'package:skeletonizer/skeletonizer.dart' show Skeletonizer;

class OverviewInsideCards extends StatelessWidget {
  const OverviewInsideCards({
    super.key,
    required this.expenseAmount,
    required this.incomeAmount,
    this.hasBorder = false,
    this.isLoading = false,
  });

  final String expenseAmount, incomeAmount;
  final bool hasBorder, isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Row(
        children: [
          Expanded(
            child: OverviewInsideCard(
              color: Get.appColors.error,
              title: 'expense'.tr,
              amount: expenseAmount,
              hasBorder: hasBorder,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: OverviewInsideCard(
              color: Get.appColors.success,
              title: 'income'.tr,
              amount: incomeAmount,
              hasBorder: hasBorder,
            ),
          ),
        ],
      ),
    );
  }
}
