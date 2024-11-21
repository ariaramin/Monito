import 'package:get/get.dart' show GetxController, Rx, RxList;
import 'package:monito/app/data/models/icon.dart';

abstract class IconPickerController extends GetxController {
  late RxList<Icon> availableIcons;

  late Rx<Icon> selectedIcon;

  void openIconPicker();

  Future<void> getCategoryIcons();

  void selectIcon(int index);
}
