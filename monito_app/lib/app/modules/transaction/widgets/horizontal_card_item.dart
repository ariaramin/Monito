part of 'card_list.dart';

class HorizontalCardItem extends StatelessWidget {
  const HorizontalCardItem({
    super.key,
    required this.image,
    required this.title,
    required this.number,
    this.isSelected = false,
    this.onTap,
  });

  final String image, title, number;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: 12.all,
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
              child: image.isNotEmpty
                  ? SquareIcon(imageUrl: image)
                  : SquareIcon(
                      child: Assets.svgs.undrawCreditCardReBlml.svg(
                        colorFilter: ColorFilter.mode(
                          Get.appColors.onPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Get.appTextTheme.regularBold2,
                  ),
                  4.verticalSpace,
                  Text(
                    number,
                    style: Get.appTextTheme.smallBold3.copyWith(
                      color: AppPalette.gray,
                    ),
                    textDirection: TextDirection.ltr,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
