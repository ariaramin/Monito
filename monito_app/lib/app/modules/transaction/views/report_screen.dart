import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/core/utils/validators.dart';
import 'package:monito/app/modules/transaction/controllers/report_controller.dart';
import 'package:monito/app/widgets/app_button.dart';
import 'package:monito/app/widgets/app_textfield.dart';
import 'package:monito/app/widgets/empty_transaction.dart';
import 'package:monito/app/widgets/title_bar.dart';
import 'package:monito/app/widgets/transaction_item/transaction_date_item.dart';
import 'package:monito/gen/assets.gen.dart';
import 'package:skeletonizer/skeletonizer.dart';

part '../widgets/report_form.dart';

class ReportScreen extends GetView<ReportController> {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('report'.tr),
        ),
        body: LiquidPullToRefresh(
          onRefresh: () async => await controller.getTransactions(),
          showChildOpacityTransition: false,
          child: CustomScrollView(
            slivers: [
              24.verticalSpace.asSliver,
              const ReportForm().asSliver,
              18.verticalSpace.asSliver,
              TitleBar(
                title: 'transactions'.tr,
                hasTrailingText: true,
                onTrailingTap: () => Get.toNamed(
                  AppRoutes.transactionList,
                  arguments: controller.filter,
                ),
              ).asSliver,
              18.verticalSpace.asSliver,
              Obx(
                () => controller.transactionDateMap.isNotEmpty
                    ? Skeletonizer.sliver(
                        enabled: controller.isLoading.value,
                        child: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: controller.transactionDateMap.length > 3
                                ? 3
                                : controller.transactionDateMap.length,
                            (context, index) => TransactionDateItem(
                              date: controller.transactionDateMap.keys
                                  .elementAt(index),
                              transactionList: controller
                                  .transactionDateMap.values
                                  .elementAt(index),
                            ),
                          ),
                        ),
                      )
                    : EmptyList(
                        image: Assets.svgs.undrawNoDataReKwbl.svg(),
                        title: 'empty_transaction_list'.tr,
                      ).asSliver,
              ),
              18.verticalSpace.asSliver,
            ],
          ),
        ),
      ),
    );
  }
}
