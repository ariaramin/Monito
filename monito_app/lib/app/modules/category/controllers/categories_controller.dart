import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/error/api_exception.dart';
import 'package:monito/app/core/error/failure.dart';
import 'package:monito/app/data/models/category.dart';
import 'package:monito/app/data/providers/category_repository.dart';

class CategoriesController extends GetxController {
  static CategoriesController get instance => Get.find();

  final CategoryRepository _categoryRepository = CategoryRepository.instance;

  List<Tab> tabs = [
    Tab(text: 'expense'.tr),
    Tab(text: 'income'.tr),
  ];

  RxList<Category> expenseCategoryList = <Category>[].obs;
  RxList<Category> incomeCategoryList = <Category>[].obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    // Set dummy data to show loading
    expenseCategoryList.value = [
      Category.empty,
      Category.empty,
      Category.empty,
      Category.empty,
      Category.empty,
      Category.empty,
      Category.empty,
    ];
    super.onInit();
  }

  @override
  void onReady() async {
    await getCategories();
    super.onReady();
  }

  Future<void> getCategories() async {
    isLoading.value = true;
    try {
      List<Category> categoryList = await _categoryRepository.getCategoryList();
      expenseCategoryList.value = categoryList
          .where((item) => item.type == CategoryType.expense)
          .toList();
      incomeCategoryList.value = categoryList
          .where((item) => item.type == CategoryType.income)
          .toList();
    } on ApiException catch (exception) {
      Failure(message: exception.message).showDialog();
    } catch (e) {
      Failure(message: 'load_categories_error'.tr).showDialog();
    } finally {
      isLoading.value = false;
    }
  }
}
