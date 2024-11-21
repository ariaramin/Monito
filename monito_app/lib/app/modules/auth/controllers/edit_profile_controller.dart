import 'package:flutter/material.dart';
import 'package:get/get.dart'
    show
        BoolExtension,
        ExtensionDialog,
        Get,
        GetxController,
        Rx,
        Trans;
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/widgets/status_dialog.dart';

class EditProfileController extends GetxController {
  final AuthRepository _authRepository = AuthRepository.instance;

  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // text field controllers
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();

  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    final currentUser = _authRepository.user.value;
    username.text = currentUser.name;
    email.text = currentUser.email;
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    super.onClose();
  }

  void edit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final currentUserId = _authRepository.user.value.id;
        await _authRepository.edit(currentUserId, {
          'name': username.text.trim(),
          'email': email.text.trim(),
        });
        Get.dialog(StatusDialog(
          message: 'edit_profile_success'.tr,
          status: Status.success,
        ));
        _authRepository.logout();
      } on ApiException catch (exception) {
        Failure(message: exception.message).showDialog();
      } catch (e) {
        Failure(message: 'edit_profile_error'.tr).showDialog();
      } finally {
        isLoading.value = false;
      }
    }
  }
}
