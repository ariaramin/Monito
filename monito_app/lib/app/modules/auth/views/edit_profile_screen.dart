import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/utils/validators.dart';
import 'package:monito/app/modules/auth/controllers/edit_profile_controller.dart';
import 'package:monito/app/widgets/app_button.dart';
import 'package:monito/app/widgets/app_textfield.dart';
import 'package:monito/app/widgets/two_step_dialog.dart';

part '../widgets/edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Scaffold(
        appBar: AppBar(title: Text('edit_profile'.tr)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              24.verticalSpace,
              const EditProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
