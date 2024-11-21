import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:get/get.dart' show Get;
import 'package:iconsax/iconsax.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';

enum Status { success, error }

class StatusDialog extends StatelessWidget {
  const StatusDialog({
    super.key,
    required this.message,
    required this.status,
  });

  final String message;
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: 16.all,
        child: Container(
          padding: 18.vertical + 24.horizontal,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Get.appColors.background,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                status == Status.success
                    ? CupertinoIcons.checkmark_alt_circle_fill
                    : Iconsax.close_circle5,
                color: status == Status.success
                    ? Get.appColors.success
                    : Get.appColors.error,
                size: 42.r,
              ),
              12.verticalSpace,
              Text(
                message,
                style:  Get.appTextTheme.regularBold2.copyWith(
                  fontFamily: 'IranSans',
                  color: Get.appColors.onBackground,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
