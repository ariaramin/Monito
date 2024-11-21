part of '../views/categories_screen.dart';

class CategoryGridview extends StatelessWidget {
  const CategoryGridview({
    super.key,
    required this.list,
  });

  final List<Category> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: list.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8.h,
      ),
      itemBuilder: (context, index) => index == list.length
          ? const AddCategoryItem()
          : CategoryItem(category: list[index]),
    );
  }
}
