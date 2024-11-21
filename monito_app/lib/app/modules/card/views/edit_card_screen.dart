import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/utils/card_number_formatter.dart';
import 'package:monito/app/core/utils/validators.dart';
import 'package:monito/app/modules/card/controllers/edit_card_controller.dart';
import 'package:monito/app/widgets/app_button.dart';
import 'package:monito/app/widgets/app_textfield.dart';

part '../widgets/edit_card_form.dart';

class EditCardScreen extends StatelessWidget {
  const EditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Scaffold(
        appBar: AppBar(title: Text('edit_card'.tr)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              24.verticalSpace,
              const EditCardForm(),
            ],
          ),
        ),
      ),
    );
  }
}
