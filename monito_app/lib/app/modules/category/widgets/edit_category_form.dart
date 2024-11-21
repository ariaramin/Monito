part of '../views/edit_category_screen.dart';

class EditCategoryForm extends GetView<EditCategoryController> {
  const EditCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.horizontal,
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => AppTextField(
                initialValue: controller.selectedIcon.value.id != null
                    ? 'change_icon'.tr
                    : null,
                prefixIcon: controller.selectedIcon.value.id != null
                    ? SizedBox(
                        width: 24.r,
                        height: 24.r,
                        child: Center(
                          child: SvgPicture.network(
                            controller.selectedIcon.value.icon,
                            colorFilter: ColorFilter.mode(
                              Get.appColors.onBackground,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      )
                    : null,
                label: 'choose_icon'.tr,
                isOpenable: true,
                onTap: () => controller.openIconPicker(),
              ),
            ),
            20.verticalSpace,
            AppTextField(
              controller: controller.title,
              label: 'category_title'.tr,
              validator: (value) => Validator.validateEmptyField(value),
            ),
            20.verticalSpace,
            AppTextField(
              controller: controller.description,
              label: 'description'.tr,
              isExpanded: true,
            ),
            20.verticalSpace,
            Obx(
              () => Wrap(
                spacing: 16.w,
                alignment: WrapAlignment.start,
                children: List.generate(
                  controller.categoryTypes.length,
                  (index) {
                    final isSelected = controller.selectedType.value ==
                        controller.categoryTypes[index];
                    return ChoiceChip(
                      label: Text(controller.categoryTypes[index].name.tr),
                      labelStyle: TextStyle(
                        color: isSelected ? Get.appColors.onPrimary : null,
                      ),
                      selected: isSelected,
                      side: BorderSide(
                        width: 2.r,
                        color: isSelected
                            ? Get.appColors.primary
                            : Get.appColors.textfield,
                      ),
                      onSelected: (bool selected) =>
                          controller.selectType(index),
                    );
                  },
                ),
              ),
            ),
            32.verticalSpace,
            Obx(
              () => AppButton(
                title: 'edit'.tr,
                isLoading: controller.isLoading.value,
                onPressed: () => controller.editCategory(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
