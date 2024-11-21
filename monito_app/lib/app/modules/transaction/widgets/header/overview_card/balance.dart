part of 'overview_card.dart';

class Balance extends GetView<HomeController> {
  const Balance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          _buildBalanceText(),
          Text(
            controller.balance.value.toWord(),
            style: Get.appTextTheme.small2
                .copyWith(color: Get.appColors.onPrimary),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          16.verticalSpace,
          Expanded(
            child: OverviewInsideCards(
              expenseAmount: controller.expenseAmount.value.toString(),
              incomeAmount: controller.incomeAmount.value.toString(),
              isLoading: controller.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceText() {
    final balance = controller.balance.value;
    final isNegative =
        controller.expenseAmount.value > controller.incomeAmount.value;
    final balanceText = isNegative ? '$balance-' : balance;

    return Text(
      balanceText,
      style: Get.appTextTheme.titleExtraBold2
          .copyWith(color: Get.appColors.onPrimary),
    ).withToman(style: Get.appTextTheme.smallBold2);
  }
}
