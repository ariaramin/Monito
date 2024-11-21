import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'
    show ExtensionDialog, Get, GetNavigation, GetView, Obx, Trans;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/widgets/menu_fab.dart';
import 'package:monito/app/widgets/square_icon.dart';
import 'package:monito/app/widgets/title_bar.dart';
import 'package:monito/app/widgets/two_step_dialog.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controllers/transaction_detail_controller.dart';

part '../widgets/transaction_info.dart';

part '../widgets/transaction_detail_header.dart';

class TransactionDetailScreen extends GetView<TransactionDetailController> {
  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('transaction_detail'.tr),
      ),
      body: LiquidPullToRefresh(
        onRefresh: () async => await controller.getTransaction(),
        showChildOpacityTransition: false,
        child: Obx(
          () => CustomScrollView(
            slivers: [
              24.verticalSpace.asSliver,
              Padding(
                padding: 16.horizontal,
                child: Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: TransactionDetailHeader(
                    iconUrl: controller.transaction.value.category.icon.icon,
                    amount: controller.transaction.value.amount
                        .toString()
                        .seRagham(),
                    categoryTitle: controller.transaction.value.category.title,
                  ),
                ),
              ).asSliver,
              18.verticalSpace.asSliver,
              Skeletonizer(
                enabled: controller.isLoading.value,
                child: TransactionInfo(
                  type: controller.transaction.value.category.type ==
                          CategoryType.expense
                      ? 'expense'.tr
                      : 'income'.tr,
                  date: controller.transaction.value.date
                      .toDateTime()
                      .toIso8601String(),
                  cardTitle: controller.transaction.value.card.title,
                ),
              ).asSliver,
              16.verticalSpace.asSliver,
              TitleBar(title: 'description'.tr).asSliver,
              12.verticalSpace.asSliver,
              Padding(
                padding: 16.horizontal,
                child: Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: Text(
                    controller.transaction.value.description,
                    style: Get.appTextTheme.regularBold1.copyWith(
                      color: AppPalette.gray,
                    ),
                  ),
                ),
              ).asSliver,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: MenuFab(
        onEditPressed: () => Get.toNamed(
          AppRoutes.editTransaction,
          arguments: controller.transaction.value,
        ),
        onDeletePressed: () => Get.dialog(
          TwoStepDialog(
            message: 'delete_transaction'.tr,
            onConfirmPressed: () async => await controller.deleteTransaction(),
          ),
        ),
      ),
    );
  }
}
