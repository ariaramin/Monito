part of '../views/profile_screen.dart';

class DateTypeList extends GetView<ProfileController> {
  const DateTypeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.dateTypes.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Obx(
        () => ListTile(
          title: Text(controller.dateTypes[index]),
          trailing:
              controller.selectedDateType.value == controller.dateTypes[index]
                  ? Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: Get.appColors.success,
                      size: 24.r,
                    )
                  : null,
          onTap: () => controller.changeDateType(controller.dateTypes[index]),
        ),
      ),
    );
  }
}
