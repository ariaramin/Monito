import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:get/get.dart' show Get, Trans;
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/app/core/values/gradients/app_gradients.dart';
import 'package:monito/app/data/models/card.dart' as card_model;
import 'package:monito/app/widgets/cached_image.dart';
import 'package:monito/gen/assets.gen.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.card,
    this.onTap,
  });

  final card_model.Card card;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 2,
        child: Skeleton.shade(
          child: Container(
            margin: 16.horizontal,
            padding: 16.all,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: AppGradients.blueGradient,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    card.bank != null && card.bank!.icon.isNotEmpty
                        ? SizedBox(
                            width: 36.h,
                            height: 36.h,
                            child: CachedImage(
                              url: card.bank!.icon,
                              color: Get.appColors.onPrimary,
                            ),
                          )
                        : SizedBox(
                            width: 36.h,
                            height: 36.h,
                            child: Assets.svgs.undrawCreditCardReBlml.svg(
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                    Text(
                      card.bank != null ? card.bank!.name : '',
                      style: Get.appTextTheme.smallExtraBold3.copyWith(
                        color: Get.appColors.onPrimary,
                      ),
                    ),
                  ],
                ),
                0.verticalSpace,
                Text(
                  card.number.toString().charRagham(separator: '   '),
                  textDirection: TextDirection.ltr,
                  style: Get.appTextTheme.regularExtraBold2.copyWith(
                    color: Get.appColors.onPrimary,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'card_title'.tr,
                          style: Get.appTextTheme.small2.copyWith(
                            color: Get.appColors.onPrimary.withOpacity(.8),
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          card.title.isNotEmpty ? card.title : 'not_entered'.tr,
                          style: Get.appTextTheme.smallBold3.copyWith(
                            color: Get.appColors.onPrimary,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'expire_date'.tr,
                          style: Get.appTextTheme.small2.copyWith(
                            color: Get.appColors.onPrimary.withOpacity(.8),
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          card.expireDate?.toDateTime().toIso8601String() ??
                              'not_entered'.tr,
                          style: Get.appTextTheme.smallBold3.copyWith(
                            color: Get.appColors.onPrimary,
                          ),
                        ).withDate(isCardDate: true),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
