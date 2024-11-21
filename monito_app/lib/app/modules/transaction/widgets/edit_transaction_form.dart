part of '../views/edit_transaction_screen.dart';

class EditTransactionForm extends GetView<EditTransactionController> {
  const EditTransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    final unit = ProfileController.instance.selectedMoneyUnit.value;
    return Padding(
      padding: 16.horizontal,
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Obx(
              () => AppTextField(
                initialValue: controller.selectedCard.value.title.isNotEmpty
                    ? controller.selectedCard.value.title
                    : null,
                label: 'card'.tr,
                validator: (value) => Validator.validateEmptyField(value),
                isOpenable: true,
                onTap: () => controller.openCardPicker(),
              ),
            ),
            20.verticalSpace,
            AppTextField(
              controller: controller.description,
              label: 'description'.tr,
              isExpanded: true,
              keyboardType: TextInputType.multiline,
              validator: (value) => Validator.validateEmptyField(value),
            ),
            20.verticalSpace,
            AppTextField(
              controller: controller.amount,
              label: 'amount'.tr,
              suffixText: 'unit'.trParams({'unit': unit}),
              keyboardType: TextInputType.number,
              validator: (value) => Validator.validateNumber(value),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                ThousandsSeparatorFormatter(),
              ],
            ),
            20.verticalSpace,
            Obx(
              () => AppTextField(
                initialValue: controller.selectedCategory.value.title.isNotEmpty
                    ? controller.selectedCategory.value.title
                    : null,
                label: 'category'.tr,
                validator: (value) => Validator.validateEmptyField(value),
                isOpenable: true,
                onTap: () => controller.openCategoryPicker(),
              ),
            ),
            20.verticalSpace,
            Obx(
              () => AppTextField(
                initialValue: controller.selectedDate.value
                    .toDateTime()
                    .toIso8601String(),
                isDate: true,
                label: 'transaction_date'.tr,
                validator: (value) => Validator.validateEmptyField(value),
                isOpenable: true,
                onTap: () => controller.selectDate(),
              ),
            ),
            32.verticalSpace,
            Obx(
              () => AppButton(
                title: 'edit'.tr,
                isLoading: controller.isLoading.value,
                onPressed: () => controller.editTransaction(),
              ),
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
