import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/app/modules/transaction/controllers/transaction_list_controller.dart';
import 'package:monito/app/widgets/empty_transaction.dart';
import 'package:monito/app/widgets/transaction_item/transaction_date_item.dart';
import 'package:monito/gen/assets.gen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TransactionListScreen extends GetView<TransactionListController> {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('all_transactions'.tr)),
      body: LiquidPullToRefresh(
        onRefresh: () async =>
            await controller.getTransactions(isRefresh: true),
        showChildOpacityTransition: false,
        child: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            24.verticalSpace.asSliver,
            Obx(
              () => controller.transactionsByDate.isNotEmpty
                  ? Skeletonizer.sliver(
                      enabled: controller.isLoading.value,
                      child: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: controller.transactionsByDate.length + 1,
                          (context, index) {
                            if (index < controller.transactionsByDate.length) {
                              final date = controller.transactionsByDate.keys
                                  .elementAt(index);
                              final transactions = controller
                                  .transactionsByDate.values
                                  .elementAt(index);
                              return TransactionDateItem(
                                date: date,
                                transactionList: transactions,
                              );
                            } else {
                              return controller.hasMore
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Get.appColors.primary,
                                      ),
                                    )
                                  : const SizedBox();
                            }
                          },
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
    );
  }
}
