import 'package:flutter/material.dart'
    show FormState, GlobalKey, TextEditingController;
import 'package:get/get.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/data/models/icon.dart';
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/data/providers/category_repository.dart';
import 'package:monito/app/modules/category/controllers/icon_picker_controller.dart';
import 'package:monito/app/widgets/status_dialog.dart';

import '../../../widgets/app_bottom_sheet.dart';
import '../widgets/icon_list.dart';
import 'categories_controller.dart';

class AddCategoryController extends GetxController
    implements IconPickerController {
  final CategoryRepository _repository = CategoryRepository.instance;

  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // text field controllers
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  RxList<Icon> availableIcons = <Icon>[].obs;

  @override
  Rx<Icon> selectedIcon = Icon(icon: '').obs;

  List<CategoryType> categoryTypes = CategoryType.values;

  Rx<CategoryType> selectedType = CategoryType.values.first.obs;

  Rx<bool> isLoading = false.obs;

  @override
  void onClose() {
    title.dispose();
    description.dispose();
    super.onClose();
  }

  void addCategory() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final user = AuthRepository.instance.user.value;
        await _repository.addCategory({
          'user': user.id,
          'icon': selectedIcon.value.id,
          'title': title.text.trim(),
          'description': description.text.trim(),
          'type': selectedType.value.name,
        });
        Get.dialog(StatusDialog(
          message: 'add_category_success'.tr,
          status: Status.success,
        ));
        CategoriesController.instance.getCategories();
        await Future.delayed(const Duration(seconds: 1));
        Get.back(closeOverlays: true);
      } on ApiException catch (exception) {
        Failure(message: exception.message).showDialog();
      } catch (e) {
        Failure(message: 'add_category_error'.tr).showDialog();
      } finally {
        isLoading.value = false;
      }
    }
  }

  void selectType(int index) => selectedType.value = CategoryType.values[index];

  @override
  void openIconPicker() async {
    if (availableIcons.isEmpty) {
      await getCategoryIcons();
      selectedIcon.value = availableIcons.first;
    }
    Get.bottomSheet(
      AppBottomSheet(
        child: IconList(controller: this),
      ),
    );
  }

  @override
  Future<void> getCategoryIcons() async {
    try {
      availableIcons.value = await _repository.getCategoryIconList();
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_icons_error'.tr).showDialog();
    }
  }

  @override
  void selectIcon(int index) => selectedIcon.value = availableIcons[index];
}
