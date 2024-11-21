part of '../views/categories_screen.dart';

class AddCategoryItem extends StatelessWidget {
  const AddCategoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.addCategory),
      child: Column(
        children: [
          const SquareIcon(
            icon: Icons.add_rounded,
            isBordered: true,
          ),
          6.verticalSpace,
          Text(
            'add'.tr,
            style: Get.appTextTheme.smallBold3,
          ),
        ],
      ),
    );
  }
}
