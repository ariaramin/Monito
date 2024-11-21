part of '../views/edit_profile_screen.dart';

class EditProfileForm extends GetView<EditProfileController> {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.horizontal,
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            AppTextField(
              controller: controller.username,
              label: 'username'.tr,
              validator: (value) => Validator.validateEmptyField(value),
            ),
            20.verticalSpace,
            AppTextField(
              controller: controller.email,
              label: 'email'.tr,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validator.validateEmail(value),
            ),
            32.verticalSpace,
            Obx(
              () => AppButton(
                title: 'edit'.tr,
                isLoading: controller.isLoading.value,
                onPressed: () => Get.dialog(
                  TwoStepDialog(
                    message: 'edit_profile_confirm'.tr,
                    onConfirmPressed: () => controller.edit(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
