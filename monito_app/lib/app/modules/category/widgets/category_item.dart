part of '../views/categories_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.categoryDetail,
        arguments: category.id,
      ),
      child: Column(
        children: [
          SquareIcon(iconUrl: category.icon.icon),
          6.verticalSpace,
          Text(
            category.title,
            style: Get.appTextTheme.smallBold3,
          ),
        ],
      ),
    );
  }
}
