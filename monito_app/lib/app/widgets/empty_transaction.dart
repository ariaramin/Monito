import 'package:flutter/material.dart'
    show BuildContext, Column, SizedBox, StatelessWidget, Text, Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:get/get.dart' show Get, GetNavigation;
import 'package:monito/app/core/extensions/theme_extension.dart'
    show ThemeExtension;
import 'package:monito/app/core/values/theme.dart' show AppPalette;

class EmptyList extends StatelessWidget {
  const EmptyList({
    super.key,
    required this.image,
    required this.title,
    this.subTitle,
  });

  final Widget image;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        32.verticalSpace,
        SizedBox(
          width: Get.height * .2,
          height: Get.height * .2,
          child: image,
        ),
        14.verticalSpace,
        Text(
          title,
          style: Get.appTextTheme.regularBold1,
        ),
        if (subTitle != null) ...{
          6.verticalSpace,
          Text(
            subTitle!,
            style: Get.appTextTheme.small2.copyWith(
              color: AppPalette.gray,
            ),
          ),
        }
      ],
    );
  }
}
