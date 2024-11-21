part of 'header.dart';

class HeaderBar extends GetView<AuthRepository> {
  const HeaderBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppIconButton(
                icon: Iconsax.user,
                onTap: () => Get.toNamed(AppRoutes.profile),
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.user.value.name,
                    style: Get.appTextTheme.smallBold3.copyWith(
                      color: Get.appColors.onPrimary,
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    controller.user.value.email,
                    style: Get.appTextTheme.smallBold3.copyWith(
                      color: Get.appColors.onPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppIconButton(
            icon: ThemeController.instance.isDarkMode.value
                ? Iconsax.sun
                : Iconsax.moon,
            onTap: () => ThemeController.instance.toggleTheme(),
          ),
        ],
      ),
    );
  }
}
