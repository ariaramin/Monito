import 'package:get/get.dart';
import 'package:monito/app/widgets/status_dialog.dart';

class Failure {
  Failure({this.message = 'مشکلی پیش آمده'});

  final String message;

  void showDialog() => Get.dialog(
        StatusDialog(
          message: message,
          status: Status.error,
        ),
      );
}
