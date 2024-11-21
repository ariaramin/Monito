import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:get/get.dart' show Get;
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/data/models/transaction.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show Jalali;
import 'package:persian_number_utility/persian_number_utility.dart'
    show StringExtensions;
import 'package:skeletonizer/skeletonizer.dart';

import 'transaction_item.dart';

class TransactionDateItem extends StatelessWidget {
  const TransactionDateItem({
    super.key,
    required this.date,
    required this.transactionList,
  });

  final Jalali date;
  final List<Transaction> transactionList;

  @override
  Widget build(BuildContext context) {
    final formatter = date.formatter;
    final balance = _calculateDailyBalance(transactionList);
    final isNegative = balance < 0;

    return Column(
      children: [
        Padding(
          padding: 16.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Skeleton.shade(
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Get.appColors.onBackground,
                      child: Text(
                        formatter.d,
                        style: Get.appTextTheme.titleBold1.copyWith(
                          fontFamily: 'IranSans',
                          color: Get.appColors.background,
                        ),
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatter.wN,
                        style: Get.appTextTheme.small2,
                      ),
                      Text(
                        '${formatter.mN} ${formatter.y}',
                        style: Get.appTextTheme.smallBold3,
                      ),
                    ],
                  ),
                ],
              ),
              Skeleton.shade(
                child: Container(
                  padding: 4.vertical + 8.horizontal,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: isNegative
                        ? Get.appColors.error
                        : Get.appColors.success,
                  ),
                  child: Text(
                    '${(balance.isNegative ? balance.abs().toString() : balance.toString()).seRagham()}${balance.isNegative ? '-' : '+'}',
                    style: Get.appTextTheme.smallExtraBold3.copyWith(
                      color: AppPalette.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        16.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactionList.length,
          itemBuilder: (context, index) => TransactionItem(
            transaction: transactionList[index],
          ),
          cacheExtent: 60,
          separatorBuilder: (context, index) => 18.verticalSpace,
        ),
        28.verticalSpace,
      ],
    );
  }

  int _calculateDailyBalance(List<Transaction> transactions) {
    return transactions.fold<int>(0, (balance, transaction) {
      if (transaction.category.type == CategoryType.expense) {
        return balance - transaction.amount;
      } else if (transaction.category.type == CategoryType.income) {
        return balance + transaction.amount;
      } else {
        return balance;
      }
    });
  }
}
