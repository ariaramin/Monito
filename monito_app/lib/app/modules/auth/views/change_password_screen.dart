import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' show ExtensionDialog, Get, GetView, Obx, Trans;
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/utils/validators.dart';
import 'package:monito/app/modules/auth/controllers/change_password_controller.dart';
import 'package:monito/app/widgets/app_button.dart';
import 'package:monito/app/widgets/app_textfield.dart';
import 'package:monito/app/widgets/two_step_dialog.dart';

part '../widgets/change_password_form.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Scaffold(
        appBar: AppBar(title: Text('change_password'.tr)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              24.verticalSpace,
              const ChangePasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
