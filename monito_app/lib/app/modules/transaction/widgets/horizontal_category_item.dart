part of 'category_list.dart';

class HorizontalCategoryItem extends StatelessWidget {
  const HorizontalCategoryItem({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  final Category category;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: 8.all,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            width: 2.r,
            color: isSelected
                ? Get.appColors.primary
                : AppPalette.gray.withOpacity(.5),
          ),
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: SquareIcon(
                iconUrl: category.icon.icon,
                padding: 8.all,
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: category.description.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.title,
                          style: Get.appTextTheme.smallBold3,
                        ),
                        4.verticalSpace,
                        Text(
                          category.description,
                          style: Get.appTextTheme.smallBold2.copyWith(
                            color: AppPalette.gray,
                          ),
                          textDirection: TextDirection.ltr,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  : Text(
                      category.title,
                      style: Get.appTextTheme.smallBold3,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
