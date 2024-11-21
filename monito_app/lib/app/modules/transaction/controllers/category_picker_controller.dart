import 'package:flutter/material.dart' show Tab;
import 'package:get/get.dart' show GetxService, Rx, RxList;
import 'package:monito/app/data/models/category.dart';

abstract class CategoryPickerController extends GetxService {
  late List<Tab> tabs;

  late RxList<Category> expenseCategoryList;
  late RxList<Category> incomeCategoryList;

  late Rx<Category> selectedCategory;

  void openCategoryPicker();

  void selectCategory(Category category);

  Future<void> getCategories();
}
