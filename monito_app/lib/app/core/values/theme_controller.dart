import 'package:flutter/material.dart' show ThemeMode;
import 'package:get/get.dart'
    show BoolExtension, Get, GetNavigation, GetxController, Inst, RxBool;
import 'package:get_storage/get_storage.dart' show GetStorage;

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  // Create a GetStorage instance
  final GetStorage _storage = GetStorage();

  static const String _key = 'isDarkTheme';

  RxBool isDarkMode = false.obs;

  @override
  void onReady() {
    isDarkMode.value = _loadFromStorage();
    super.onReady();
  }

  ThemeMode get theme => _loadFromStorage() ? ThemeMode.dark : ThemeMode.light;

  bool _loadFromStorage() =>
      _storage.read<bool>(_key) ?? false; // Default to false (light theme)

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;

    Get.changeThemeMode(_loadFromStorage() ? ThemeMode.light : ThemeMode.dark);
    // Save the theme mode to storage
    _storage.write(_key, !_loadFromStorage());
  }
}
