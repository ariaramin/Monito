import 'dart:io' show InternetAddress, SocketException;

import 'package:get/get.dart' show Get, GetxService, Inst;

class NetworkService extends GetxService {
  static NetworkService get instance => Get.find();

  Future<bool> checkNetworkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
