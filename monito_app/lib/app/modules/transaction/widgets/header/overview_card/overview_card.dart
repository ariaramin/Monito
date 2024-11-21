import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/data/models/transaction.dart';
import 'package:monito/app/modules/transaction/controllers/home_controller.dart';
import 'package:monito/app/widgets/icon_button.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/app/widgets/overview_cards.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show Jalali;
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

part 'balance.dart';
part 'chart.dart';
part 'balance_chart.dart';

class OverviewCard extends GetView<HomeController> {
  const OverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppPalette.slateBlue,
        boxShadow: [
          BoxShadow(
            color: Get.appColors.primary,
            blurRadius: 25,
            spreadRadius: -12,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          Obx(
            () => AspectRatio(
              aspectRatio: 2.1,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: controller.isShowingBalance.value
                    ? const Balance()
                    : const BalanceChart(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'month_balance'.trParams({
            'month': Jalali.now().formatter.mN,
          }),
          style: Get.appTextTheme.smallBold3.copyWith(
            color: Get.appColors.onPrimary,
          ),
        ),
        Obx(
          () => AppIconButton(
            icon: controller.isShowingBalance.value
                ? Iconsax.chart
                : Iconsax.wallet_1,
            onTap: controller.toggleCardContent,
          ),
        ),
      ],
    );
  }
}
