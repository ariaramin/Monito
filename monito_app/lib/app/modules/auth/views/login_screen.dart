import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/core/utils/validators.dart';
import 'package:monito/app/modules/auth/widgets/form_caption.dart';
import 'package:monito/app/widgets/app_button.dart';
import 'package:monito/app/widgets/app_textfield.dart';
import 'package:monito/gen/assets.gen.dart';

import '../controllers/login_controller.dart';

part '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: 16.horizontal,
            child: Column(
              children: [
                56.verticalSpace,
                SizedBox(
                  width: 118.r,
                  height: 118.r,
                  child: Assets.svgs.monitoLogo.svg(),
                ),
                18.verticalSpace,
                const LoginForm(),
                const Spacer(),
                FormCaption(
                  firstText: 'have_not_account'.tr,
                  secondText: 'register'.tr,
                  onTap: () => Get.offAndToNamed(AppRoutes.register),
                ),
                32.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
