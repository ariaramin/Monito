import 'package:flutter/material.dart';
import 'package:get/get.dart'
    show
        BoolExtension,
        ExtensionDialog,
        Get,
        GetNavigation,
        GetxController,
        Rx,
        Trans;
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/widgets/status_dialog.dart';

class ChangePasswordController extends GetxController {
  final AuthRepository _authRepository = AuthRepository.instance;

  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // text field controllers
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirm = TextEditingController();

  Rx<bool> isOldPasswordVisible = false.obs;
  Rx<bool> isPasswordVisible = false.obs;
  Rx<bool> isPasswordConfirmVisible = false.obs;

  Rx<bool> isLoading = false.obs;

  @override
  void onClose() {
    oldPassword.dispose();
    password.dispose();
    passwordConfirm.dispose();
    super.onClose();
  }

  void change() async {
    Get.back();
    isLoading.value = true;
    try {
      final currentUserId = _authRepository.user.value.id;
      await _authRepository.edit(currentUserId, {
        'oldPassword': oldPassword.text.trim(),
        'password': password.text.trim(),
        'passwordConfirm': passwordConfirm.text.trim(),
      });
      Get.dialog(StatusDialog(
        message: 'change_password_success'.tr,
        status: Status.success,
      ));
      _authRepository.logout();
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'change_password_error'.tr).showDialog();
    } finally {
      isLoading.value = false;
    }
  }

  void toggleOldPasswordVisibility() =>
      isOldPasswordVisible.value = !isOldPasswordVisible.value;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void togglePasswordConfirmVisibility() =>
      isPasswordConfirmVisible.value = !isPasswordConfirmVisible.value;
}
