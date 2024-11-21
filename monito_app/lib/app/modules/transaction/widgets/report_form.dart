part of '../views/report_screen.dart';

class ReportForm extends GetView<ReportController> {
  const ReportForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.horizontal,
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => AppTextField(
                      initialValue: controller.startDate.value
                          .toDateTime()
                          .toIso8601String(),
                      isDate: true,
                      label: 'from_date'.tr,
                      validator: (value) => Validator.validateEmptyField(value),
                      isOpenable: true,
                      onTap: () => controller.selectDateRange(),
                    ),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Obx(
                    () => AppTextField(
                      initialValue: controller.endDate.value
                          .toDateTime()
                          .toIso8601String(),
                      isDate: true,
                      label: 'to_date'.tr,
                      validator: (value) => Validator.validateEmptyField(value),
                      isOpenable: true,
                      onTap: () => controller.selectDateRange(),
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => AppTextField(
                      initialValue:
                          controller.selectedCategory.value.title.isNotEmpty
                              ? controller.selectedCategory.value.title
                              : null,
                      label: 'category'.tr,
                      validator: (value) => Validator.validateEmptyField(value),
                      isOpenable: true,
                      onTap: () => controller.openCategoryPicker(),
                    ),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Obx(
                    () => AppTextField(
                      initialValue:
                          controller.selectedCard.value.title.isNotEmpty
                              ? controller.selectedCard.value.title
                              : null,
                      label: 'card'.tr,
                      validator: (value) => Validator.validateEmptyField(value),
                      isOpenable: true,
                      onTap: () => controller.openCardPicker(),
                    ),
                  ),
                ),
              ],
            ),
            32.verticalSpace,
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'filter'.tr,
                      isLoading: controller.isLoading.value,
                      onPressed: () => controller.getTransactions(),
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: AppButton(
                      title: 'remove_filter'.tr,
                      isPrimary: false,
                      onPressed: controller.selectedCard.value.id.isNotEmpty ||
                              controller.selectedCategory.value.id.isNotEmpty
                          ? () => controller.resetFilter()
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
