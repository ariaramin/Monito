part of '../views/cards_screen.dart';

class AddCardItem extends StatelessWidget {
  const AddCardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.addCard),
      child: Skeleton.keep(
        child: Container(
          margin: 16.horizontal,
          padding: 12.all,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Get.appColors.background,
            border: Border.all(
              width: 4.r,
              color: Get.appColors.secondary,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_rounded,
                size: 24.r,
                color: Get.isDarkMode
                    ? Get.appColors.onBackground
                    : Get.appColors.secondary,
              ),
              6.horizontalSpace,
              Text(
                'add_card'.tr,
                style: Get.appTextTheme.regularBold1.copyWith(
                  color: Get.isDarkMode
                      ? Get.appColors.onBackground
                      : Get.appColors.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
