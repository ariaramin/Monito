import 'package:get/get.dart' show Get, GetxService, Inst;

import '../models/category.dart';
import '../models/icon.dart';
import '../services/pocketbase.dart';
import 'auth_repository.dart';

class CategoryRepository extends GetxService {
  static CategoryRepository get instance => Get.find();

  final PocketBaseService _pocketBaseService = PocketBaseService.instance;
  static const String collectionName = 'categories';

  Future<void> addCategory(Map<String, dynamic> data) async {
    try {
      await _pocketBaseService.create(
        collectionName,
        data: data,
        expand: 'icon',
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<Category> getCategory(String categoryId) async {
    try {
      final result = await _pocketBaseService.getOne(
        collectionName,
        id: categoryId,
        expand: 'icon',
      );
      return Category.fromRecord(result);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Category>> getCategoryList() async {
    try {
      final user = AuthRepository.instance.user.value;
      final result = await _pocketBaseService.getList(
        collectionName,
        expand: 'icon',
        filter: 'user = null || user = \'${user.id}\'',
      );
      return result.items.map((item) => Category.fromRecord(item)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Icon>> getCategoryIconList() async {
    try {
      final result = await _pocketBaseService.getList('icons');
      return result.items.map((item) => Icon.fromRecord(item)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> editCategory(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _pocketBaseService.update(
        collectionName,
        id: categoryId,
        data: data,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _pocketBaseService.delete(
        collectionName,
        id: categoryId,
      );
    } catch (_) {
      rethrow;
    }
  }
}
