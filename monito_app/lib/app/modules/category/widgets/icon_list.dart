import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' show Get, Obx, Trans;
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/modules/category/controllers/icon_picker_controller.dart';
import 'package:monito/app/widgets/square_icon.dart';

class IconList extends StatelessWidget {
  const IconList({
    super.key,
    required this.controller,
  });

  final IconPickerController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Get.appColors.background,
      color: Get.appColors.primary,
      onRefresh: () async => controller.getCategoryIcons(),
      child: controller.availableIcons.isNotEmpty
          ? Padding(
              padding: 16.top + 16.horizontal,
              child: GridView.builder(
                itemCount: controller.availableIcons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => controller.selectIcon(index),
                  child: Obx(
                    () => controller.availableIcons[index].id ==
                            controller.selectedIcon.value.id
                        ? SquareIcon(
                            iconUrl: controller.availableIcons[index].icon,
                          )
                        : Padding(
                            padding: 8.all,
                            child: SvgPicture.network(
                              controller.availableIcons[index].icon,
                            ),
                          ),
                  ),
                ),
              ),
            )
          : Text(
              'load_icons_error'.tr,
              style: Get.appTextTheme.regularBold2,
              textAlign: TextAlign.center,
            ),
    );
  }
}
