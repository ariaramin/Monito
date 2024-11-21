import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/modules/category/views/categories_screen.dart';
import 'package:monito/app/widgets/square_icon.dart';

import '../controllers/category_picker_controller.dart';
part 'category_gridview.dart';
part 'horizontal_category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.controller,
  });

  final CategoryPickerController controller;

  @override
  Widget build(BuildContext context) {
    final int initialIndex =
        controller.selectedCategory.value.type == CategoryType.income
            ? controller.tabs.length - 1
            : 0;
    return DefaultTabController(
      length: controller.tabs.length,
      initialIndex: initialIndex,
      child: Column(
        children: [
          16.verticalSpace,
          CategoriesTabBar(tabs: controller.tabs),
          controller.expenseCategoryList.isNotEmpty ||
                  controller.incomeCategoryList.isNotEmpty
              ? Expanded(
                  child: RefreshIndicator(
                    backgroundColor: Get.appColors.background,
                    color: Get.appColors.primary,
                    onRefresh: controller.getCategories,
                    child: Padding(
                      padding: 16.top + 16.horizontal,
                      child: TabBarView(
                        children: [
                          CategoryGridView(
                            categories: controller.expenseCategoryList,
                            controller: controller,
                          ),
                          CategoryGridView(
                            categories: controller.incomeCategoryList,
                            controller: controller,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Text(
                  'load_categories_error'.tr,
                  style: Get.appTextTheme.regularBold2,
                  textAlign: TextAlign.center,
                ),
        ],
      ),
    );
  }
}
