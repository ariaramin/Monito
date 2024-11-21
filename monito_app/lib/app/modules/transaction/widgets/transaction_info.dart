part of '../views/transaction_detail_screen.dart';

class TransactionInfo extends GetView<TransactionDetailController> {
  const TransactionInfo({
    super.key,
    required this.type,
    required this.date,
    required this.cardTitle,
  });

  final String type, date, cardTitle;

  @override
  Widget build(BuildContext context) {
    return Skeleton.shade(
      child: Container(
        padding: 12.vertical,
        margin: 16.horizontal,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Get.appColors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  'transaction_type'.tr,
                  style: Get.appTextTheme.smallBold3.copyWith(
                    color: AppPalette.white.withOpacity(.6),
                  ),
                ),
                12.verticalSpace,
                Text(
                  type,
                  style: Get.appTextTheme.regularBold2.copyWith(
                    color: AppPalette.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'date'.tr,
                  style: Get.appTextTheme.smallBold3.copyWith(
                    color: AppPalette.white.withOpacity(.6),
                  ),
                ),
                12.verticalSpace,
                Text(
                  date,
                  style: Get.appTextTheme.regularBold2.copyWith(
                    color: AppPalette.white,
                  ),
                ).withDate(),
              ],
            ),
            Column(
              children: [
                Text(
                  'card'.tr,
                  style: Get.appTextTheme.smallBold3.copyWith(
                    color: AppPalette.white.withOpacity(.6),
                  ),
                ),
                12.verticalSpace,
                Text(
                  cardTitle,
                  style: Get.appTextTheme.regularBold2.copyWith(
                    color: AppPalette.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
