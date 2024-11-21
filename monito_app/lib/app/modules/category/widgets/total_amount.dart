part of '../views/category_detail_screen.dart';

class TotalAmount extends StatelessWidget {
  const TotalAmount({
    super.key,
    required this.categoryType,
    required this.totalAmount,
  });

  final CategoryType categoryType;
  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Skeleton.shade(
      child: Container(
        padding: 12.all,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: categoryType == CategoryType.expense
              ? Get.appColors.error
              : Get.appColors.success,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryType == CategoryType.expense
                  ? 'total_expense'.tr
                  : 'total_income'.tr,
              style: Get.appTextTheme.regularBold2.copyWith(
                color: Get.appColors.background,
              ),
            ),
            Text(
              totalAmount,
              style: Get.appTextTheme.regularExtraBold2.copyWith(
                color: Get.appColors.background,
              ),
            ).withToman(
              style: Get.appTextTheme.smallBold2.copyWith(
                color: Get.appColors.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
