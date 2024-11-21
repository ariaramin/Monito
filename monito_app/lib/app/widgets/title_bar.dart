import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/core/extensions/num_extension.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    super.key,
    required this.title,
    this.hasTrailingText = false,
    this.onTrailingTap,
  });

  final String title;
  final bool hasTrailingText;
  final Function()? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Get.appTextTheme.titleBold1,
          ),
          if (hasTrailingText)
            GestureDetector(
              onTap: onTrailingTap,
              child: Text(
                'see_more'.tr,
                style: Get.appTextTheme.small3.copyWith(color: AppPalette.gray),
              ),
            ),
        ],
      ),
    );
  }
}
