import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/utils/validators.dart';
import 'package:monito/app/modules/category/controllers/add_category_controller.dart';
import 'package:monito/app/widgets/app_button.dart';
import 'package:monito/app/widgets/app_textfield.dart';

part '../widgets/category_form.dart';

class AddCategoryScreen extends GetView<AddCategoryController> {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Scaffold(
        appBar: AppBar(title: Text('add_category'.tr)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              24.verticalSpace,
              const CategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}
