part of '../views/profile_screen.dart';

class MoneyUnitList extends GetView<ProfileController> {
  const MoneyUnitList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.moneyUnits.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Obx(
        () => ListTile(
          title: Text(controller.moneyUnits[index].title),
          leading: SizedBox(
            height: 32.h,
            child: controller.moneyUnits[index].image.image(),
          ),
          trailing: controller.selectedMoneyUnit.value ==
                  controller.moneyUnits[index].title
              ? Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  color: Get.appColors.success,
                  size: 24.r,
                )
              : null,
          onTap: () => controller.changeMoneyUnit(controller.moneyUnits[index]),
        ),
      ),
    );
  }
}
