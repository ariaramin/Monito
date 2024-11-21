import 'package:get/get.dart' show Trans;

class ApiException implements Exception {
  final int? code;
  final String message;

  const ApiException({this.code, this.message = 'خطایی رخ داده است.'});

  factory ApiException.authException(String code) {
    switch (code) {
      case 'validation_required':
        return ApiException(
          code: 0,
          message: 'validation_required'.tr,
        );
      case 'validation_length_out_of_range':
        return ApiException(
          code: 0,
          message: 'validation_length_out_of_range'.tr,
        );
      case 'validation_invalid_email':
        return ApiException(
          code: 0,
          message: 'validation_invalid_email'.tr,
        );
      default:
        return const ApiException();
    }
  }
}
