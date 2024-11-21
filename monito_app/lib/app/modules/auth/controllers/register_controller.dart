import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/widgets/status_dialog.dart';

class RegisterController extends GetxController {
  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // text field controllers
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Rx<bool> isPasswordVisible = false.obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await AuthRepository.instance.register(
          fullName: username.text.trim(),
          email: email.text.trim(),
          password: password.text.trim(),
        );
        Get.dialog(StatusDialog(
          message: 'register_success'.tr,
          status: Status.success,
        ));
        await Future.delayed(const Duration(seconds: 1));
        Get.back(closeOverlays: true);
      } on ApiException catch (exception) {
        Failure(message: exception.message).showDialog();
      } catch (e) {
        Failure(message: 'register_error'.tr).showDialog();
      } finally {
        isLoading.value = false;
      }
    }
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;
}
