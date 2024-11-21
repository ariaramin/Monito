import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart'
    show ColorScheme, TextTheme, Theme, ThemeData;
import 'package:get/get.dart' show Get, GetInterface, GetNavigation, Trans;
import 'package:monito/app/modules/auth/controllers/profile_controller.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show
        DateTimeExt,
        Jalali,
        JalaliRange,
        showPersianDatePicker,
        showPersianDateRangePicker;

import 'theme_extension.dart';

extension GetxExtension on GetInterface {
  Future<JalaliRange?> showDateRangePicker({
    JalaliRange? initialDateRange,
    Jalali? currentDate,
  }) async {
    final type = ProfileController.instance.selectedDateType.value;
    if (type == 'gregorian'.tr) {
      final dateTimeRange = await material.showDateRangePicker(
        context: context!,
        initialDateRange: initialDateRange != null
            ? material.DateTimeRange(
                start: initialDateRange.start.toDateTime(),
                end: initialDateRange.end.toDateTime(),
              )
            : null,
        currentDate: currentDate?.toDateTime(),
        firstDate: DateTime(2024, 1, 1),
        lastDate: DateTime(2099, 12, 31),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              useMaterial3: false,
              colorScheme: ColorScheme(
                brightness: Get.theme.brightness,
                primary: Get.appColors.primary,
                onPrimary: Get.appColors.onPrimary,
                secondary: Get.appColors.secondary,
                onSecondary: Get.appColors.onSecondary,
                error: Get.appColors.error,
                onError: Get.appColors.onError,
                surface: Get.appColors.background,
                onSurface: Get.appColors.onBackground,
              ),
              textTheme: TextTheme(
                labelSmall: Get.theme.textTheme.labelSmall
                    ?.copyWith(fontFamily: 'IranSans'),
                labelMedium: Get.theme.textTheme.labelMedium
                    ?.copyWith(fontFamily: 'IranSans'),
                labelLarge: Get.theme.textTheme.labelLarge
                    ?.copyWith(fontFamily: 'IranSans'),
                bodySmall: Get.theme.textTheme.bodySmall
                    ?.copyWith(fontFamily: 'IranSans'),
                bodyMedium: Get.theme.textTheme.bodyMedium
                    ?.copyWith(fontFamily: 'IranSans'),
                bodyLarge: Get.theme.textTheme.bodyLarge
                    ?.copyWith(fontFamily: 'IranSans'),
                titleSmall: Get.theme.textTheme.titleSmall
                    ?.copyWith(fontFamily: 'IranSans'),
                titleMedium: Get.theme.textTheme.titleMedium
                    ?.copyWith(fontFamily: 'IranSans'),
                titleLarge: Get.theme.textTheme.titleLarge
                    ?.copyWith(fontFamily: 'IranSans'),
                headlineSmall: Get.theme.textTheme.headlineSmall
                    ?.copyWith(fontFamily: 'IranSans'),
                headlineMedium: Get.theme.textTheme.headlineMedium
                    ?.copyWith(fontFamily: 'IranSans'),
                headlineLarge: Get.theme.textTheme.headlineLarge
                    ?.copyWith(fontFamily: 'IranSans'),
                displaySmall: Get.theme.textTheme.displaySmall
                    ?.copyWith(fontFamily: 'IranSans'),
                displayMedium: Get.theme.textTheme.displayMedium
                    ?.copyWith(fontFamily: 'IranSans'),
                displayLarge: Get.theme.textTheme.displayLarge
                    ?.copyWith(fontFamily: 'IranSans'),
              ),
            ),
            child: child!,
          );
        },
      );
      return dateTimeRange != null
          ? JalaliRange(
              start: dateTimeRange.start.toJalali(),
              end: dateTimeRange.end.toJalali(),
            )
          : null;
    }
    return await showPersianDateRangePicker(
      context: context!,
      initialDateRange: initialDateRange,
      currentDate: currentDate,
      firstDate: Jalali(1403, 1),
      lastDate: Jalali(1450, 9),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme(
              brightness: Get.theme.brightness,
              primary: Get.appColors.primary,
              onPrimary: Get.appColors.onPrimary,
              secondary: Get.appColors.secondary,
              onSecondary: Get.appColors.onSecondary,
              error: Get.appColors.error,
              onError: Get.appColors.onError,
              surface: Get.appColors.background,
              onSurface: Get.appColors.onBackground,
            ),
            textTheme: TextTheme(
              labelSmall: Get.theme.textTheme.labelSmall
                  ?.copyWith(fontFamily: 'IranSans'),
              labelMedium: Get.theme.textTheme.labelMedium
                  ?.copyWith(fontFamily: 'IranSans'),
              labelLarge: Get.theme.textTheme.labelLarge
                  ?.copyWith(fontFamily: 'IranSans'),
              bodySmall: Get.theme.textTheme.bodySmall
                  ?.copyWith(fontFamily: 'IranSans'),
              bodyMedium: Get.theme.textTheme.bodyMedium
                  ?.copyWith(fontFamily: 'IranSans'),
              bodyLarge: Get.theme.textTheme.bodyLarge
                  ?.copyWith(fontFamily: 'IranSans'),
              titleSmall: Get.theme.textTheme.titleSmall
                  ?.copyWith(fontFamily: 'IranSans'),
              titleMedium: Get.theme.textTheme.titleMedium
                  ?.copyWith(fontFamily: 'IranSans'),
              titleLarge: Get.theme.textTheme.titleLarge
                  ?.copyWith(fontFamily: 'IranSans'),
              headlineSmall: Get.theme.textTheme.headlineSmall
                  ?.copyWith(fontFamily: 'IranSans'),
              headlineMedium: Get.theme.textTheme.headlineMedium
                  ?.copyWith(fontFamily: 'IranSans'),
              headlineLarge: Get.theme.textTheme.headlineLarge
                  ?.copyWith(fontFamily: 'IranSans'),
              displaySmall: Get.theme.textTheme.displaySmall
                  ?.copyWith(fontFamily: 'IranSans'),
              displayMedium: Get.theme.textTheme.displayMedium
                  ?.copyWith(fontFamily: 'IranSans'),
              displayLarge: Get.theme.textTheme.displayLarge
                  ?.copyWith(fontFamily: 'IranSans'),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<Jalali?> showDatePicker({Jalali? initialDate}) async {
    final type = ProfileController.instance.selectedDateType.value;

    if (type == 'gregorian'.tr) {
      // Show Gregorian date picker
      final dateTime = await material.showDatePicker(
        context: context!,
        initialDate:
            initialDate != null ? initialDate.toDateTime() : DateTime.now(),
        firstDate: DateTime(2024, 1, 1),
        lastDate: DateTime(2099, 12, 31),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              useMaterial3: false,
              colorScheme: ColorScheme(
                brightness: Get.theme.brightness,
                primary: Get.appColors.primary,
                onPrimary: Get.appColors.onPrimary,
                secondary: Get.appColors.secondary,
                onSecondary: Get.appColors.onSecondary,
                error: Get.appColors.error,
                onError: Get.appColors.onError,
                surface: Get.appColors.background,
                onSurface: Get.appColors.onBackground,
              ),
              textTheme: TextTheme(
                labelSmall: Get.theme.textTheme.labelSmall
                    ?.copyWith(fontFamily: 'IranSans'),
                labelMedium: Get.theme.textTheme.labelMedium
                    ?.copyWith(fontFamily: 'IranSans'),
                labelLarge: Get.theme.textTheme.labelLarge
                    ?.copyWith(fontFamily: 'IranSans'),
                bodySmall: Get.theme.textTheme.bodySmall
                    ?.copyWith(fontFamily: 'IranSans'),
                bodyMedium: Get.theme.textTheme.bodyMedium
                    ?.copyWith(fontFamily: 'IranSans'),
                bodyLarge: Get.theme.textTheme.bodyLarge
                    ?.copyWith(fontFamily: 'IranSans'),
                titleSmall: Get.theme.textTheme.titleSmall
                    ?.copyWith(fontFamily: 'IranSans'),
                titleMedium: Get.theme.textTheme.titleMedium
                    ?.copyWith(fontFamily: 'IranSans'),
                titleLarge: Get.theme.textTheme.titleLarge
                    ?.copyWith(fontFamily: 'IranSans'),
                headlineSmall: Get.theme.textTheme.headlineSmall
                    ?.copyWith(fontFamily: 'IranSans'),
                headlineMedium: Get.theme.textTheme.headlineMedium
                    ?.copyWith(fontFamily: 'IranSans'),
                headlineLarge: Get.theme.textTheme.headlineLarge
                    ?.copyWith(fontFamily: 'IranSans'),
                displaySmall: Get.theme.textTheme.displaySmall
                    ?.copyWith(fontFamily: 'IranSans'),
                displayMedium: Get.theme.textTheme.displayMedium
                    ?.copyWith(fontFamily: 'IranSans'),
                displayLarge: Get.theme.textTheme.displayLarge
                    ?.copyWith(fontFamily: 'IranSans'),
              ),
            ),
            child: child!,
          );
        },
      );
      return dateTime != null ? Jalali.fromDateTime(dateTime) : null;
    }

    // Show Persian (Jalali) date picker
    return await showPersianDatePicker(
      context: Get.context!,
      initialDate: initialDate ?? Jalali.now(),
      firstDate: Jalali(1403, 1),
      lastDate: Jalali(1450, 9),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme(
              brightness: Get.theme.brightness,
              primary: Get.appColors.primary,
              onPrimary: Get.appColors.onPrimary,
              secondary: Get.appColors.secondary,
              onSecondary: Get.appColors.onSecondary,
              error: Get.appColors.error,
              onError: Get.appColors.onError,
              surface: Get.appColors.background,
              onSurface: Get.appColors.onBackground,
            ),
            textTheme: TextTheme(
              labelSmall: Get.theme.textTheme.labelSmall
                  ?.copyWith(fontFamily: 'IranSans'),
              labelMedium: Get.theme.textTheme.labelMedium
                  ?.copyWith(fontFamily: 'IranSans'),
              labelLarge: Get.theme.textTheme.labelLarge
                  ?.copyWith(fontFamily: 'IranSans'),
              bodySmall: Get.theme.textTheme.bodySmall
                  ?.copyWith(fontFamily: 'IranSans'),
              bodyMedium: Get.theme.textTheme.bodyMedium
                  ?.copyWith(fontFamily: 'IranSans'),
              bodyLarge: Get.theme.textTheme.bodyLarge
                  ?.copyWith(fontFamily: 'IranSans'),
              titleSmall: Get.theme.textTheme.titleSmall
                  ?.copyWith(fontFamily: 'IranSans'),
              titleMedium: Get.theme.textTheme.titleMedium
                  ?.copyWith(fontFamily: 'IranSans'),
              titleLarge: Get.theme.textTheme.titleLarge
                  ?.copyWith(fontFamily: 'IranSans'),
              headlineSmall: Get.theme.textTheme.headlineSmall
                  ?.copyWith(fontFamily: 'IranSans'),
              headlineMedium: Get.theme.textTheme.headlineMedium
                  ?.copyWith(fontFamily: 'IranSans'),
              headlineLarge: Get.theme.textTheme.headlineLarge
                  ?.copyWith(fontFamily: 'IranSans'),
              displaySmall: Get.theme.textTheme.displaySmall
                  ?.copyWith(fontFamily: 'IranSans'),
              displayMedium: Get.theme.textTheme.displayMedium
                  ?.copyWith(fontFamily: 'IranSans'),
              displayLarge: Get.theme.textTheme.displayLarge
                  ?.copyWith(fontFamily: 'IranSans'),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
