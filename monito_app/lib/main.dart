import 'package:flutter/material.dart' show SafeArea, runApp;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' show Get, Inst;
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:monito/app/core/values/theme_controller.dart';
import 'package:monito/app/data/services/auth.dart';
import 'package:monito/app/data/services/pocketbase.dart'
    show PocketBaseService;

import 'app/app.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  Get.lazyPut(() => PocketBaseService());
  Get.lazyPut(() => AuthService());
  Get.put(ThemeController());
  await GetStorage.init();
  runApp(const SafeArea(child: Monito()));
}
