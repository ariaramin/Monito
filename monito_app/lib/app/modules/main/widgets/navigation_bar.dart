import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:monito/app/core/extensions/num_extension.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedItem;
  final Function(int)? onTap;

  const BottomNavigation({
    super.key,
    required this.selectedItem,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: selectedItem,
      items: [
        _getBottomNavigationItem(
          Iconsax.home,
          Iconsax.home_15,
          'home'.tr,
        ),
        _getBottomNavigationItem(
          Iconsax.category,
          Iconsax.category5,
          'categories'.tr,
        ),
        _getBottomNavigationItem(
          Iconsax.card,
          Iconsax.card5,
          'cards'.tr,
        ),
        _getBottomNavigationItem(
          Iconsax.chart,
          Iconsax.chart_26,
          'report'.tr,
        ),
      ],
    );
  }

  BottomNavigationBarItem _getBottomNavigationItem(
    IconData? icon,
    IconData? activeIcon,
    String title,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: 4.bottom,
        child: Icon(icon),
      ),
      activeIcon: Padding(
        padding: 4.bottom,
        child: Icon(activeIcon),
      ),
      label: title,
    );
  }
}
