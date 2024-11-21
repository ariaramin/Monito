import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/data/models/transaction.dart';
import 'package:monito/app/widgets/cached_image.dart';
import 'package:monito/gen/assets.gen.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../square_icon.dart';

part 'icon.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Get.appTextTheme;
    final colors = Get.appColors;
    final isExpense = transaction.category.type == CategoryType.expense;
    final amountText =
        '${transaction.amount.toString().seRagham()}${isExpense ? '-' : '+'}';
    final amountColor = isExpense ? colors.error : colors.success;

    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: () => Get.toNamed(
        AppRoutes.transactionDetail,
        arguments: transaction.id,
      ),
      child: Padding(
        padding: 16.horizontal,
        child: Row(
          children: [
            Skeleton.shade(
              child: TransactionIcon(
                categoryIconUrl: transaction.category.icon.icon,
                bankIconUrl: transaction.card.bank?.icon,
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.category.title,
                    style: theme.regularBold1,
                  ),
                  6.verticalSpace,
                  Text(
                    transaction.description,
                    style: theme.small3.copyWith(color: AppPalette.gray),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amountText,
                  style: theme.regularExtraBold1.copyWith(color: amountColor),
                ).withToman(
                  style: theme.smallBold1.copyWith(color: amountColor),
                ),
                6.verticalSpace,
                Text(
                  transaction.date.toDateTime().toIso8601String(),
                  style: theme.small2.copyWith(color: AppPalette.gray),
                ).withDate(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
