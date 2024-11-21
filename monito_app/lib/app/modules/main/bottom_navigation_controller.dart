import 'package:flutter/material.dart' show Widget;
import 'package:get/get.dart' show GetxController, IntExtension, RxInt;
import 'package:monito/app/modules/card/views/cards_screen.dart';
import 'package:monito/app/modules/category/views/categories_screen.dart';
import 'package:monito/app/modules/transaction/views/report_screen.dart';
import 'package:monito/app/modules/transaction/views/home_screen.dart';

class BottomNavigationController extends GetxController {
  List<Widget> screens = const [
    HomeScreen(),
    CategoriesScreen(),
    CardsScreen(),
    ReportScreen(),
  ];

  RxInt selectedItem = 0.obs;

  void onItemTap(int index) => selectedItem.value = index;
}
