import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/core/utils/excel_generator.dart';
import 'package:monito/app/modules/card/controllers/card_detail_controller.dart';
import 'package:monito/app/modules/card/widgets/card_item.dart';
import 'package:monito/app/widgets/empty_transaction.dart';
import 'package:monito/app/widgets/menu_fab.dart';
import 'package:monito/app/widgets/overview_cards.dart';
import 'package:monito/app/widgets/title_bar.dart';
import 'package:monito/app/widgets/transaction_item/transaction_date_item.dart';
import 'package:monito/app/widgets/two_step_dialog.dart';
import 'package:monito/gen/assets.gen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardDetailScreen extends GetView<CardDetailController> {
  const CardDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('card_detail'.tr),
      ),
      body: LiquidPullToRefresh(
        onRefresh: () async => await Future.wait([
          controller.getCard(),
          controller.getTransactions(),
        ]),
        showChildOpacityTransition: false,
        child: Obx(
          () => CustomScrollView(
            slivers: [
              24.verticalSpace.asSliver,
              Column(
                children: [
                  Skeletonizer(
                    enabled: controller.cardLoading.value,
                    child: CardItem(card: controller.card.value),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: 16.horizontal,
                    child: OverviewInsideCards(
                      expenseAmount: controller.expenseAmount.value.toString(),
                      incomeAmount: controller.incomeAmount.value.toString(),
                      hasBorder: true,
                      isLoading: controller.cardLoading.value,
                    ),
                  ),
                ],
              ).asSliver,
              16.verticalSpace.asSliver,
              TitleBar(
                title: 'recent_transactions'.tr,
                hasTrailingText: true,
                onTrailingTap: () => Get.toNamed(
                  AppRoutes.transactionList,
                  arguments: "card.id='${controller.cardId}'",
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
          AppRoutes.editCard,
          arguments: controller.card.value,
        ),
        onExportPressed: () => generateExcelFile(
          'card_transaction'.trParams({'card': controller.card.value.title}),
          controller.transactionList,
        ),
        onDeletePressed: () => Get.dialog(
          TwoStepDialog(
            message: 'delete_card'.tr,
            onConfirmPressed: () async => await controller.deleteCard(),
          ),
        ),
      ),
    );
  }
}
