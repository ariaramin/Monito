import 'package:get/get.dart' show Bindings, Get, Inst;

import '../controllers/report_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportController());
  }
}
