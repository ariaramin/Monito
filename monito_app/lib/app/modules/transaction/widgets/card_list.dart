import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' show Get, Obx, Trans;
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/widgets/square_icon.dart';
import 'package:monito/gen/assets.gen.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../controllers/card_picker_controller.dart';

part 'horizontal_card_item.dart';

class CardList extends StatelessWidget {
  const CardList({
    super.key,
    required this.controller,
  });

  final CardPickerController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Get.appColors.background,
      color: Get.appColors.primary,
      onRefresh: () async => controller.getCards(),
      child: controller.availableCards.isNotEmpty
          ? Padding(
              padding: 18.top + 16.horizontal,
              child: GridView.builder(
                itemCount: controller.availableCards.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) => Obx(
                  () => HorizontalCardItem(
                    image: controller.availableCards[index].bank!.icon,
                    title: controller.availableCards[index].title,
                    number: controller.availableCards[index].number
                        .toString()
                        .charRagham(separator: '  '),
                    isSelected: controller.availableCards[index].id ==
                        controller.selectedCard.value.id,
                    onTap: () => controller.selectCard(index),
                  ),
                ),
              ),
            )
          : Center(
              child: Text(
                'load_cards_error'.tr,
                style: Get.appTextTheme.regularBold2,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
