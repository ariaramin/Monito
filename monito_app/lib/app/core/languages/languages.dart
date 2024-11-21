import 'package:get/get.dart' show Translations;

part 'fa.dart';

class AppLanguages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'fa_IR': faIr,
      };
}
