import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/modules/category/controllers/categories_controller.dart';
import 'package:monito/app/widgets/square_icon.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:skeletonizer/skeletonizer.dart';

part '../widgets/category_item.dart';
part '../widgets/add_category_item.dart';
part '../widgets/category_tab_bar.dart';
part '../widgets/category_gridview.dart';

class CategoriesScreen extends GetView<CategoriesController> {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: controller.tabs.length,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              scrolledUnderElevation: 0,
              title: Text('category'.tr),
              pinned: true,
              bottom: CategoriesTabBar(tabs: controller.tabs),
            ),
            SliverFillRemaining(
              child: LiquidPullToRefresh(
                onRefresh: () async => controller.getCategories(),
                showChildOpacityTransition: false,
                child: Obx(
                  () => Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: Padding(
                      padding: 24.top,
                      child: TabBarView(
                        children: [
                          CategoryGridview(
                              list: controller.expenseCategoryList),
                          CategoryGridview(list: controller.incomeCategoryList),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
