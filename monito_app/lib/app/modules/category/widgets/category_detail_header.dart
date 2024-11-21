part of '../views/category_detail_screen.dart';

class CategoryDetailHeader extends GetView<CategoryDetailController> {
  const CategoryDetailHeader({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.description,
  });

  final String iconUrl, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SquareIcon(
          iconUrl: iconUrl,
          size: 86.h,
          padding: 14.all,
        ),
        12.verticalSpace,
        Text(
          title,
          style: Get.appTextTheme.titleBold1,
        ),
        if (controller.category.value.description.isNotEmpty) ...{
          8.verticalSpace,
          Text(
            description,
            style: Get.appTextTheme.smallBold3.copyWith(
              color: AppPalette.gray,
            ),
            textAlign: TextAlign.center,
          ),
        }
      ],
    );
  }
}
