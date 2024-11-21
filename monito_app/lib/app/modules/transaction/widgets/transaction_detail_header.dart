part of '../views/transaction_detail_screen.dart';

class TransactionDetailHeader extends GetView<TransactionDetailController> {
  const TransactionDetailHeader({
    super.key,
    required this.iconUrl,
    required this.amount,
    required this.categoryTitle,
  });

  final String iconUrl, amount, categoryTitle;

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
          amount,
          style: Get.appTextTheme.titleExtraBold2,
        ).withToman(style: Get.appTextTheme.titleExtraBold1),
        4.verticalSpace,
        Text(
          categoryTitle,
          style: Get.appTextTheme.regularBold2,
        ),
      ],
    );
  }
}
