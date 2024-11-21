import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/modules/transaction/controllers/home_controller.dart';
import 'package:monito/app/widgets/empty_transaction.dart';
import 'package:monito/app/widgets/title_bar.dart';
import 'package:monito/app/widgets/transaction_item/transaction_item.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/gen/assets.gen.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/header/header.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: () async => await controller.getTransactions(),
        showChildOpacityTransition: false,
        child: CustomScrollView(
          slivers: [
            const Header().asSliver,
            78.verticalSpace.asSliver,
            TitleBar(
              title: 'recent_transactions'.tr,
              hasTrailingText: true,
              onTrailingTap: () => Get.toNamed(AppRoutes.transactionList),
            ).asSliver,
            18.verticalSpace.asSliver,
            Obx(
              () => controller.transactionList.isNotEmpty
                  ? Skeletonizer.sliver(
                      enabled: controller.isLoading.value,
                      child: SliverList.separated(
                        itemCount: controller.transactionList.length > 6
                            ? 6
                            : controller.transactionList.length,
                        itemBuilder: (context, index) => TransactionItem(
                          transaction: controller.transactionList[index],
                        ),
                        separatorBuilder: (context, index) => 18.verticalSpace,
                      ),
                    )
                  : EmptyList(
                      image: Assets.svgs.undrawNoDataReKwbl.svg(),
                      title: 'empty_transaction_list'.tr,
                      subTitle: 'empty_transaction_list_caption'.tr,
                    ).asSliver,
            ),
            68.verticalSpace.asSliver,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.appColors.primary,
        child: Center(
          child: Icon(
            Icons.add_rounded,
            size: 32.r,
            color: Get.appColors.onPrimary,
          ),
        ),
        onPressed: () => Get.toNamed(AppRoutes.addTransaction),
      ),
    );
  }
}
