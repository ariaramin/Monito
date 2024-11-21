import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/utils/thousands_separator_formatter.dart';
import 'package:monito/app/core/utils/validators.dart';
import 'package:monito/app/modules/auth/controllers/profile_controller.dart';
import 'package:monito/app/modules/transaction/controllers/edit_transaction_controller.dart';
import 'package:monito/app/widgets/app_button.dart';
import 'package:monito/app/widgets/app_textfield.dart';

part '../widgets/edit_transaction_form.dart';

class EditTransactionScreen extends StatelessWidget {
  const EditTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Scaffold(
        appBar: AppBar(title: Text('edit_transaction'.tr)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              24.verticalSpace,
              const EditTransactionForm(),
            ],
          ),
        ),
      ),
    );
  }
}
