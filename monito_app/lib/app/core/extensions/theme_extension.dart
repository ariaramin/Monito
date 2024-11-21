import 'package:flutter/material.dart' show ThemeData;
import 'package:get/get.dart' show GetInterface, GetNavigation;
import 'package:monito/app/core/values/theme.dart';
import 'package:monito/app/core/values/colors/app_colors_extension.dart';
import 'package:monito/app/core/values/text_styles/app_text_theme_extension.dart';

extension AppThemeExtension on ThemeData {
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? AppThemes.lightAppColors;

  AppTextThemeExtension get appTextTheme =>
      extension<AppTextThemeExtension>() ?? AppThemes.lightTextTheme;
}

extension ThemeExtension on GetInterface {
  AppTextThemeExtension get appTextTheme => theme.appTextTheme;

  AppColorsExtension get appColors => theme.appColors;
}
