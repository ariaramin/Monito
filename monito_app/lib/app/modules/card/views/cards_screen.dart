import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/modules/card/controllers/cards_controller.dart';
import 'package:monito/app/widgets/empty_transaction.dart';
import 'package:monito/gen/assets.gen.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/card_item.dart';

part '../widgets/add_card_item.dart';

class CardsScreen extends GetView<CardsController> {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('card'.tr)),
      body: LiquidPullToRefresh(
        onRefresh: () async => await controller.getCards(),
        showChildOpacityTransition: false,
        child: CustomScrollView(
          slivers: [
            24.verticalSpace.asSliver,
            Obx(
              () => controller.cardList.isNotEmpty
                  ? Skeletonizer.sliver(
                      enabled: controller.isLoading.value,
                      child: SliverList.separated(
                        itemCount: controller.cardList.length > 8
                            ? 9
                            : controller.cardList.length + 1,
                        itemBuilder: (context, index) =>
                            index == controller.cardList.length || index == 8
                                ? const AddCardItem()
                                : CardItem(
                                    card: controller.cardList[index],
                                    onTap: () => Get.toNamed(
                                      AppRoutes.cardDetail,
                                      arguments: controller.cardList[index].id,
                                    ),
                                  ),
                        separatorBuilder: (context, index) => 16.verticalSpace,
                      ),
                    )
                  : Column(
                      children: [
                        EmptyList(
                          image: Assets.svgs.undrawCreditCardReBlml.svg(),
                          title: 'empty_card_list'.tr,
                          subTitle: 'empty_card_list_caption'.tr,
                        ),
                        16.verticalSpace,
                        const AddCardItem(),
                      ],
                    ).asSliver,
            ),
            16.verticalSpace.asSliver,
          ],
        ),
      ),
    );
  }
}
