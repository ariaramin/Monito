import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/modules/auth/controllers/profile_controller.dart';
import 'package:monito/app/widgets/square_icon.dart';
import 'package:monito/app/widgets/two_step_dialog.dart';

part '../widgets/shadow_container.dart';
part '../widgets/user_info_tile.dart';
part '../widgets/money_unit_list.dart';
part '../widgets/date_type_list.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('profile'.tr)),
      body: Padding(
        padding: 24.vertical,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ShadowContainer(child: UserInfoTile()),
              24.verticalSpace,
              ShadowContainer(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.settings.length,
                  itemBuilder: (context, index) {
                    final setting = controller.settings[index];
                    return ListTile(
                      title: Text(setting.title),
                      leading: Icon(
                        setting.icon,
                        color: Get.appColors.primary,
                      ),
                      trailing: const Icon(Iconsax.arrow_left_2),
                      onTap: setting.onTap,
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    indent: 12.w,
                    endIndent: 12.w,
                    height: 8.h,
                    color: AppPalette.gray.withOpacity(.2),
                  ),
                ),
              ),
              24.verticalSpace,
              ShadowContainer(
                child: ListTile(
                  title: Text('logout'.tr),
                  textColor: Get.appColors.error,
                  leading: Icon(
                    Iconsax.logout5,
                    color: Get.appColors.error,
                  ),
                  onTap: () => Get.dialog(
                    TwoStepDialog(
                      message: 'sure_to_logout'.tr,
                      onConfirmPressed: () => controller.logout(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
