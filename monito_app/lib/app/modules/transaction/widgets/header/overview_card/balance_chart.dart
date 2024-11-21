part of 'overview_card.dart';

class BalanceChart extends GetView<HomeController> {
  const BalanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentDay = Jalali.now().day;
    final bool isSingleChartPeriod = currentDay <= 15;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          8.verticalSpace,
          Expanded(
            child: isSingleChartPeriod
                ? _buildPeriodChart(1, currentDay)
                : PageView(
                    controller: controller.chartPageController,
                    children: [
                      _buildPeriodChart(1, 15),
                      _buildPeriodChart(16, currentDay),
                    ],
                  ),
          ),
          if (!isSingleChartPeriod) ...[
            8.verticalSpace,
            SmoothPageIndicator(
              controller: controller.chartPageController,
              count: 2,
              effect: WormEffect(
                dotWidth: 4.h,
                dotHeight: 4.h,
                spacing: 6.r,
                activeDotColor: AppPalette.white,
                dotColor: AppPalette.white.withOpacity(.2),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Transaction> _filterTransactions(
    List<Transaction> transactions,
    int startDay,
    int endDay,
  ) {
    return transactions
        .where((item) =>
            item.date.month == Jalali.now().month &&
            item.date.day >= startDay &&
            item.date.day <= endDay)
        .toList();
  }

  Widget _buildPeriodChart(int startDay, int endDay) {
    return Obx(
      () {
        final expenseSpots = _filterTransactions(
          controller.expenseList,
          startDay,
          endDay,
        );
        final incomeSpots = _filterTransactions(
          controller.incomeList,
          startDay,
          endDay,
        );

        return Chart(
          maxX: (endDay - startDay + 1).toDouble(),
          startFrom: startDay,
          expenseSpots: expenseSpots,
          incomeSpots: incomeSpots,
        );
      },
    );
  }
}
