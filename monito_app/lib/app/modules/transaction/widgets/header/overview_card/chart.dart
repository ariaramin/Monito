part of 'overview_card.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.maxX,
    required this.startFrom,
    required this.expenseSpots,
    required this.incomeSpots,
  });

  final double maxX;
  final int startFrom;
  final List<Transaction> expenseSpots;
  final List<Transaction> incomeSpots;

  @override
  Widget build(BuildContext context) {
    // Cache the spots data
    final expenseChartBarData = _createLineChartBarData(
      expenseSpots,
      AppPalette.tomato,
    );
    final incomeChartBarData = _createLineChartBarData(
      incomeSpots,
      AppPalette.mediumseaGreen,
    );
    return Padding(
      padding: 4.all,
      child: LineChart(
        LineChartData(
          gridData: gridData,
          titlesData: titlesData1,
          borderData: borderData,
          lineBarsData: [
            incomeChartBarData,
            expenseChartBarData,
          ],
          maxX: maxX,
        ),
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
      ),
    );
  }

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  LineChartBarData _createLineChartBarData(
    List<Transaction> transactions,
    Color color,
  ) {
    final spotsMap =
        transactions.fold<Map<int, double>>({}, (map, transaction) {
      final day = transaction.date.day;
      map[day] = (map[day] ?? 0) + transaction.amount;
      return map;
    });

    final spots = List.generate(Jalali.now().day - startFrom + 1, (index) {
      final day = index + 1;
      // Assuming startFrom represents an offset for the day of the month
      final offset = startFrom > 15 ? 15 : 0;
      final yValue = spotsMap[day + offset] ?? 0;
      return FlSpot(day.toDouble(), yValue);
    });

    return LineChartBarData(
      isCurved: false,
      color: color,
      barWidth: 4.r,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: spots,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final day = (value.toInt() + (startFrom > 15 ? 15 : 0)).toString();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.h,
      child: Text(
        day,
        style: AppTypography.smallBold1.copyWith(color: AppPalette.white),
      ),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 16.h,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(show: false);
}
