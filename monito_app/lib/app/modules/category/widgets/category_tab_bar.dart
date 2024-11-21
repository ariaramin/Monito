part of '../views/categories_screen.dart';

class CategoriesTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoriesTabBar({
    super.key,
    required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      margin: 16.horizontal + 8.bottom,
      padding: 4.all,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Get.appColors.secondary,
      ),
      child: TabBar(
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
