import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/core/utils/excel_generator.dart';
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/widgets/empty_transaction.dart';
import 'package:monito/app/widgets/menu_fab.dart';
import 'package:monito/app/widgets/square_icon.dart';
import 'package:monito/app/widgets/title_bar.dart';
import 'package:monito/app/widgets/transaction_item/transaction_date_item.dart';
import 'package:monito/app/widgets/two_step_dialog.dart';
import 'package:monito/gen/assets.gen.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controllers/category_detail_controller.dart';

part '../widgets/total_amount.dart';
part '../widgets/category_detail_header.dart';

class CategoryDetailScreen extends GetView<CategoryDetailController> {
  const CategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('category_detail'.tr),
      ),
      body: LiquidPullToRefresh(
        onRefresh: () async => await controller.getCategory(),
        showChildOpacityTransition: false,
        child: Obx(
          () => CustomScrollView(
            slivers: [
              24.verticalSpace.asSliver,
              Padding(
                padding: 16.horizontal,
                child: Column(
                  children: [
                    Skeletonizer(
                      enabled: controller.cardLoading.value,
                      child: CategoryDetailHeader(
                        iconUrl: controller.category.value.icon.icon,
                        title: controller.category.value.title,
                        description: controller.category.value.description,
                      ),
                    ),
                    18.verticalSpace,
                    Skeletonizer(
                      enabled: controller.cardLoading.value,
                      child: TotalAmount(
                        categoryType: controller.category.value.type,
                        totalAmount: controller.totalAmount.value,
                      ),
                    ),
                  ],
                ),
              ).asSliver,
              16.verticalSpace.asSliver,
              TitleBar(
                title: 'recent_transactions'.tr,
                hasTrailingText: true,
                onTrailingTap: () => Get.toNamed(
                  AppRoutes.transactionList,
                  arguments: "category.id='${controller.category.value.id}'",
                ),
              ).asSliver,
              18.verticalSpace.asSliver,
              controller.transactionDateMap.isNotEmpty
                  ? Skeletonizer.sliver(
                      enabled: controller.transactionLoading.value,
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
              72.verticalSpace.asSliver,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: MenuFab(
        onEditPressed: () => Get.toNamed(
          AppRoutes.editCategory,
          arguments: controller.category.value,
        ),
        onExportPressed: () => generateExcelFile(
          'category_transaction'
              .trParams({'category': controller.category.value.title}),
          controller.transactionList,
        ),
        onDeletePressed: () => Get.dialog(
          TwoStepDialog(
            message: 'delete_category'.tr,
            onConfirmPressed: () async => await controller.deleteCategory(),
          ),
        ),
      ),
    );
  }
}
