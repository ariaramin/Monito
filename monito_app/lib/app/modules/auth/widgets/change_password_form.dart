part of '../views/change_password_screen.dart';

class ChangePasswordForm extends GetView<ChangePasswordController> {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.horizontal,
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            AppTextField(
              controller: controller.oldPassword,
              label: 'current_password'.tr,
              isPassword: true,
              isPasswordVisible: controller.isOldPasswordVisible.value,
              onPasswordSuffixIconTap: () =>
                  controller.toggleOldPasswordVisibility(),
              validator: (value) => Validator.validateEmptyField(value),
            ),
            20.verticalSpace,
            Obx(
              () => AppTextField(
                controller: controller.password,
                label: 'new_password'.tr,
                isPassword: true,
                isPasswordVisible: controller.isPasswordVisible.value,
                onPasswordSuffixIconTap: () =>
                    controller.togglePasswordVisibility(),
                validator: (value) => Validator.validatePassword(value),
              ),
            ),
            20.verticalSpace,
            Obx(
              () => AppTextField(
                controller: controller.passwordConfirm,
                label: 'repeat_new_password'.tr,
                isPassword: true,
                isPasswordVisible: controller.isPasswordConfirmVisible.value,
                onPasswordSuffixIconTap: () =>
                    controller.togglePasswordConfirmVisibility(),
                validator: (value) => Validator.validatePassword(value),
              ),
            ),
            32.verticalSpace,
            Obx(
              () => AppButton(
                title: 'submit'.tr,
                isLoading: controller.isLoading.value,
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    Get.dialog(
                      TwoStepDialog(
                        message: 'change_password_confirm'.tr,
                        onConfirmPressed: () => controller.change(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
