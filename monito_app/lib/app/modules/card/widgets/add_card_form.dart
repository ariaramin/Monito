part of '../views/add_card_screen.dart';

class AddCardForm extends GetView<AddCardController> {
  const AddCardForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.horizontal,
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            AppTextField(
              controller: controller.title,
              label: 'card_title'.tr,
              validator: (value) => Validator.validateEmptyField(value),
            ),
            20.verticalSpace,
            Obx(
              () => AppTextField(
                controller: controller.number,
                label: 'card_number'.tr,
                helperText: controller.cardBank.value.name.isNotEmpty
                    ? controller.cardBank.value.name
                    : 'bank_not_found'.tr,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validator.validateCardNumber(value?.removeAllWhitespace),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CardNumberFormatter(),
                ],
              ),
            ),
            20.verticalSpace,
            Obx(
              () => AppTextField(
                initialValue: controller.cardExpireDate.value
                    ?.toDateTime()
                    .toIso8601String(),
                isDate: true,
                isCardDate: true,
                label: 'expire_date'.tr,
                isOpenable: true,
                onTap: () => controller.selectExpireDate(),
              ),
            ),
            32.verticalSpace,
            Obx(
              () => AppButton(
                title: 'add'.tr,
                isLoading: controller.isLoading.value,
                onPressed: () => controller.addCard(),
              ),
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
