import 'package:flutter/material.dart' show Color, ThemeExtension;

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.error,
    required this.onError,
    required this.success,
    required this.onSuccess,
    required this.background,
    required this.onBackground,
    required this.shadow,
    required this.textfield,
  });

  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color error;
  final Color onError;
  final Color success;
  final Color onSuccess;
  final Color background;
  final Color onBackground;
  final Color shadow;
  final Color textfield;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? error,
    Color? onError,
    Color? success,
    Color? onSuccess,
    Color? background,
    Color? onBackground,
    Color? shadow,
    Color? textfield,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      shadow: shadow ?? this.shadow,
      textfield: textfield ?? this.textfield,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      textfield: Color.lerp(textfield, other.textfield, t)!,
    );
  }
}
