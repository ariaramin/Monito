import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Trans;
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 8.top + 16.horizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'about'.tr,
            style: Get.appTextTheme.regular2,
            textAlign: TextAlign.justify,
          ),
          // 20.verticalSpace,
          // AppButton(
          //   title: 'support'.tr,
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}
