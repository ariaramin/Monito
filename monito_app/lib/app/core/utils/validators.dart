import 'package:get/get.dart' show GetUtils, Trans;
import 'package:persian_number_utility/persian_number_utility.dart'
    show StringExtensions;

class Validator {
  static String? validateEmptyField(String? value) =>
      (value == null || value.isEmpty) ? 'must_not_empty'.tr : null;

  static String? validateNumber(String? value) {
    if (validateEmptyField(value) != null) {
      return validateEmptyField(value);
    }
    if (int.tryParse(value!.replaceAll(',', '')) == null) {
      return 'invalid_number'.tr;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (validateEmptyField(value) != null) {
      return validateEmptyField(value);
    }
    if (!GetUtils.isEmail(value!)) {
      return 'invalid_email'.tr;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (validateEmptyField(value) != null) {
      return validateEmptyField(value);
    }
    if (value!.length < 6) {
      return 'short_password'.tr;
    }
    return null;
  }

  static String? validateCardNumber(String? value) {
    if (validateEmptyField(value) != null) {
      return validateEmptyField(value);
    }
    if (!value!.isValidBankCardNumber()) {
      return 'invalid_card_number'.tr;
    }
    return null;
  }
}
