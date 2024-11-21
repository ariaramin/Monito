part of '../views/login_screen.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Text(
            'login_account'.tr,
            style: Get.appTextTheme.titleBold1,
          ),
          24.verticalSpace,
          AppTextField(
            controller: controller.email,
            label: 'email'.tr,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validator.validateEmail(value),
          ),
          20.verticalSpace,
          Obx(
            () => AppTextField(
              controller: controller.password,
              label: 'password'.tr,
              isPassword: true,
              isPasswordVisible: controller.isPasswordVisible.value,
              onPasswordSuffixIconTap: () => controller.togglePasswordVisibility(),
              validator: (value) => Validator.validatePassword(value),
            ),
          ),
          32.verticalSpace,
          Obx(
            () => AppButton(
              title: 'login'.tr,
              isLoading: controller.isLoading.value,
              onPressed: () => controller.login(),
            ),
          ),
        ],
      ),
    );
  }
}
