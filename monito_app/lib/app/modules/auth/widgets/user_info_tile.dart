part of '../views/profile_screen.dart';

class UserInfoTile extends GetView<AuthRepository> {
  const UserInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.all,
      child: Obx(
        () => Row(
          children: [
            const SquareIcon(icon: Iconsax.user),
            16.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.user.value.name,
                  style: Get.appTextTheme.regularBold2,
                ),
                6.verticalSpace,
                Text(
                  controller.user.value.email,
                  style: Get.appTextTheme.small3.copyWith(
                    color: AppPalette.gray,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
