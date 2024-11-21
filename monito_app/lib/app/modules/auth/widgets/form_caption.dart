import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/values/theme.dart';

class FormCaption extends StatelessWidget {
  const FormCaption({
    super.key,
    required this.firstText,
    required this.secondText,
    this.onTap,
  });

  final String firstText;
  final String secondText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: firstText,
          style: Get.appTextTheme.small3.copyWith(
            fontFamily: 'IranSans',
            color: AppPalette.gray,
          ),
          children: [
            TextSpan(
              text: secondText,
              style: Get.appTextTheme.smallBold3,
            ),
          ],
        ),
      ),
    );
  }
}
