import 'package:flutter/material.dart' show BuildContext, Scaffold, Widget;
import 'package:get/get.dart' show GetView, Obx;

import 'bottom_navigation_controller.dart';
import 'widgets/navigation_bar.dart';

class MainScreen extends GetView<BottomNavigationController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // body: IndexedStack(
        //   index: controller.selectedItem.value,
        //   children: controller.screens,
        // ),
        body: controller.screens[controller.selectedItem.value],
        bottomNavigationBar: BottomNavigation(
          selectedItem: controller.selectedItem.value,
          onTap: (index) => controller.onItemTap(index),
        ),
      ),
    );
  }
}
