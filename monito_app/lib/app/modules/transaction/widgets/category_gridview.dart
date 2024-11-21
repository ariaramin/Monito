part of 'category_list.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView({
    super.key,
    required this.categories,
    required this.controller,
  });

  final List<Category> categories;
  final CategoryPickerController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 3,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return Obx(
          () => HorizontalCategoryItem(
            category: category,
            isSelected: category.id == controller.selectedCategory.value.id,
            onTap: () => controller.selectCategory(category),
          ),
        );
      },
    );
  }
}
