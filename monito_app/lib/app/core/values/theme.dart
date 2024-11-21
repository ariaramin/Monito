import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:monito/app/core/extensions/num_extension.dart';
import 'colors/app_colors_extension.dart';
import 'text_styles/app_text_theme_extension.dart';

part 'colors/app_palette.dart';
part 'text_styles/app_typography.dart';

class AppThemes {
  // Light Theme
  static final light = () {
    final defaultTheme = ThemeData.light();

    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'IranSans',
      scaffoldBackgroundColor: _lightAppColors.background,
      primaryColor: _lightAppColors.primary,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: _lightAppColors.background,
        selectedItemColor: _lightAppColors.primary,
        selectedLabelStyle: _lightTextTheme.small2,
        unselectedLabelStyle: _lightTextTheme.small2,
        selectedIconTheme: IconThemeData(
          size: 26.r,
          color: _lightAppColors.primary,
        ),
        unselectedIconTheme: IconThemeData(
          size: 24.r,
          color: _lightAppColors.onBackground,
        ),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: _lightTextTheme.titleBold1.copyWith(
          fontFamily: 'IranSans',
          color: _lightAppColors.primary,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      tabBarTheme: TabBarTheme(
        dividerHeight: 0,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: _lightAppColors.primary,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: _lightTextTheme.regularBold2.copyWith(
          fontFamily: 'IranSans',
        ),
        unselectedLabelStyle: _lightTextTheme.small3.copyWith(
          fontFamily: 'IranSans',
        ),
        unselectedLabelColor: _lightAppColors.onPrimary.withOpacity(.8),
        labelColor: _lightAppColors.onPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: _lightTextTheme.regularBold1.copyWith(
          fontFamily: 'IranSans',
          color: AppPalette.gray,
        ),
        floatingLabelStyle: _lightTextTheme.smallBold3.copyWith(
          fontFamily: 'IranSans',
        ),
        suffixStyle: _lightTextTheme.smallBold3,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 2.r,
            color: _lightAppColors.onBackground,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 2.r,
            color: _lightAppColors.textfield,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 2.r,
            color: _lightAppColors.primary,
          ),
        ),
        helperStyle: _lightTextTheme.smallBold2.copyWith(
          fontFamily: 'IranSans',
          color: _lightAppColors.primary,
        ),
        errorStyle: _lightTextTheme.smallBold2.copyWith(
          fontFamily: 'IranSans',
          color: _lightAppColors.error,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 2.r,
            color: _lightAppColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 2.r,
            color: _lightAppColors.error,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: _lightTextTheme.regularBold2.copyWith(
            fontFamily: 'iranSans',
          ),
          backgroundColor: _lightAppColors.primary,
          foregroundColor: _lightAppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          minimumSize: Size.fromHeight(56.h),
        ),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: 16.horizontal,
        titleTextStyle:
            _lightTextTheme.regularBold1.copyWith(fontFamily: 'IranSans'),
      ),
      chipTheme: ChipThemeData(
          backgroundColor: _lightAppColors.background,
          labelStyle:
              _lightTextTheme.smallBold3.copyWith(fontFamily: 'IranSans'),
          selectedColor: _lightAppColors.primary,
          checkmarkColor: _lightAppColors.onPrimary,
          iconTheme: IconThemeData(size: 20.r)),
      textTheme: defaultTheme.textTheme.copyWith(
        // Default text style for Text widget.
        bodyMedium: _lightTextTheme.regularBold1,
      ),
      colorScheme: defaultTheme.colorScheme.copyWith(
        secondary: _lightAppColors.primary,
      ),
      extensions: [
        _lightAppColors,
        _lightTextTheme,
      ],
    );
  }();

  static final _lightAppColors = AppColorsExtension(
    primary: AppPalette.royalBlue,
    onPrimary: AppPalette.white,
    secondary: AppPalette.darkslateBlue,
    onSecondary: AppPalette.white,
    background: AppPalette.white,
    onBackground: AppPalette.black,
    error: AppPalette.tomato,
    onError: AppPalette.white,
    success: AppPalette.mediumseaGreen,
    onSuccess: AppPalette.white,
    shadow: AppPalette.black.withOpacity(.2),
    textfield: AppPalette.chineseWhite,
  );

  static get lightAppColors => _lightAppColors;

  static final _lightTextTheme = AppTextThemeExtension(
    titleExtraBold2: AppTypography.titleExtraBold2.copyWith(
      color: _lightAppColors.onBackground,
    ),
    titleExtraBold1: AppTypography.titleExtraBold1.copyWith(
      color: _lightAppColors.onBackground,
    ),
    titleBold1: AppTypography.titleBold1.copyWith(
      color: _lightAppColors.onBackground,
    ),
    regularExtraBold2: AppTypography.regularExtraBold2.copyWith(
      color: _lightAppColors.onBackground,
    ),
    regularBold2: AppTypography.regularBold2.copyWith(
      color: _lightAppColors.onBackground,
    ),
    regular2: AppTypography.regular2.copyWith(
      color: _lightAppColors.onBackground,
    ),
    regularExtraBold1: AppTypography.regularExtraBold1.copyWith(
      color: _lightAppColors.onBackground,
    ),
    regularBold1: AppTypography.regularBold1.copyWith(
      color: _lightAppColors.onBackground,
    ),
    smallExtraBold3: AppTypography.smallExtraBold3.copyWith(
      color: _lightAppColors.onBackground,
    ),
    smallBold3: AppTypography.smallBold3.copyWith(
      color: _lightAppColors.onBackground,
    ),
    small3: AppTypography.small3.copyWith(
      color: _lightAppColors.onBackground,
    ),
    smallBold2: AppTypography.smallBold2.copyWith(
      color: _lightAppColors.onBackground,
    ),
    small2: AppTypography.small2.copyWith(
      color: _lightAppColors.onBackground,
    ),
    smallBold1: AppTypography.smallBold1.copyWith(
      color: _lightAppColors.onBackground,
    ),
    small1: AppTypography.small1.copyWith(
      color: _lightAppColors.onBackground,
    ),
  );

  static get lightTextTheme => _lightTextTheme;

  // Dark Theme
  static final dark = () {
    final defaultTheme = ThemeData.dark();

    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'IranSans',
      scaffoldBackgroundColor: _darkAppColors.background,
      primaryColor: _darkAppColors.primary,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: _darkAppColors.background,
        selectedItemColor: _darkAppColors.primary,
        selectedLabelStyle: _darkTextTheme.small2,
        unselectedLabelStyle: _darkTextTheme.small2,
        selectedIconTheme: IconThemeData(
          size: 26.r,
          color: _darkAppColors.primary,
        ),
        unselectedIconTheme: IconThemeData(
          size: 24.r,
          color: _darkAppColors.onBackground,
        ),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: _darkTextTheme.titleBold1.copyWith(
          fontFamily: 'IranSans',
          color: _darkAppColors.primary,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      tabBarTheme: TabBarTheme(
        dividerHeight: 0,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: _darkAppColors.primary,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: _darkTextTheme.regularBold2.copyWith(
          fontFamily: 'IranSans',
        ),
        unselectedLabelStyle: _darkTextTheme.small3.copyWith(
          fontFamily: 'IranSans',
        ),
        unselectedLabelColor: _darkAppColors.onPrimary.withOpacity(.8),
        labelColor: _darkAppColors.onPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: _darkTextTheme.regularBold1.copyWith(
          fontFamily: 'IranSans',
          color: AppPalette.gray,
        ),
        floatingLabelStyle: _darkTextTheme.smallBold3.copyWith(
          fontFamily: 'IranSans',
        ),
        suffixStyle: _darkTextTheme.smallBold3,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 2.r,
            color: _darkAppColors.onBackground,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 2.r,
            color: _darkAppColors.textfield,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 2.r,
            color: _darkAppColors.primary,
          ),
        ),
        helperStyle: _darkTextTheme.smallBold2.copyWith(
          fontFamily: 'IranSans',
          color: _darkAppColors.primary,
        ),
        errorStyle: _darkTextTheme.smallBold2.copyWith(
          fontFamily: 'IranSans',
          color: _darkAppColors.error,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 2.r,
            color: _darkAppColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 2.r,
            color: _darkAppColors.error,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: _darkTextTheme.regularBold2.copyWith(
            fontFamily: 'iranSans',
          ),
          backgroundColor: _darkAppColors.primary,
          foregroundColor: _darkAppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          minimumSize: Size.fromHeight(56.h),
        ),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: 16.horizontal,
        titleTextStyle:
            _darkTextTheme.regularBold1.copyWith(fontFamily: 'IranSans'),
      ),
      chipTheme: ChipThemeData(
          backgroundColor: _darkAppColors.background,
          labelStyle:
              _darkTextTheme.smallBold3.copyWith(fontFamily: 'IranSans'),
          selectedColor: _darkAppColors.primary,
          checkmarkColor: _darkAppColors.onPrimary,
          iconTheme: IconThemeData(size: 20.r)),
      textTheme: defaultTheme.textTheme.copyWith(
        // Default text style for Text widget.
        bodyMedium: _darkTextTheme.regularBold1,
      ),
      colorScheme: defaultTheme.colorScheme.copyWith(
        secondary: _darkAppColors.primary,
      ),
      extensions: [
        _darkAppColors,
        _darkTextTheme,
      ],
    );
  }();

  static final _darkAppColors = AppColorsExtension(
    primary: AppPalette.royalBlue,
    onPrimary: AppPalette.white,
    secondary: AppPalette.darkslateBlue,
    onSecondary: AppPalette.white,
    background: AppPalette.richBlack,
    onBackground: AppPalette.white,
    error: AppPalette.tomato,
    onError: AppPalette.white,
    success: AppPalette.mediumseaGreen,
    onSuccess: AppPalette.white,
    shadow: AppPalette.white.withOpacity(.2),
    textfield: AppPalette.chineseWhite,
  );

  static final _darkTextTheme = AppTextThemeExtension(
    titleExtraBold2: AppTypography.titleExtraBold2.copyWith(
      color: _darkAppColors.onBackground,
    ),
    titleExtraBold1: AppTypography.titleExtraBold1.copyWith(
      color: _darkAppColors.onBackground,
    ),
    titleBold1: AppTypography.titleBold1.copyWith(
      color: _darkAppColors.onBackground,
    ),
    regularExtraBold2: AppTypography.regularExtraBold2.copyWith(
      color: _darkAppColors.onBackground,
    ),
    regularBold2: AppTypography.regularBold2.copyWith(
      color: _darkAppColors.onBackground,
    ),
    regular2: AppTypography.regular2.copyWith(
      color: _darkAppColors.onBackground,
    ),
    regularExtraBold1: AppTypography.regularExtraBold1.copyWith(
      color: _darkAppColors.onBackground,
    ),
    regularBold1: AppTypography.regularBold1.copyWith(
      color: _darkAppColors.onBackground,
    ),
    smallExtraBold3: AppTypography.smallExtraBold3.copyWith(
      color: _darkAppColors.onBackground,
    ),
    smallBold3: AppTypography.smallBold3.copyWith(
      color: _darkAppColors.onBackground,
    ),
    small3: AppTypography.small3.copyWith(
      color: _darkAppColors.onBackground,
    ),
    smallBold2: AppTypography.smallBold2.copyWith(
      color: _darkAppColors.onBackground,
    ),
    small2: AppTypography.small2.copyWith(
      color: _darkAppColors.onBackground,
    ),
    smallBold1: AppTypography.smallBold1.copyWith(
      color: _darkAppColors.onBackground,
    ),
    small1: AppTypography.small1.copyWith(
      color: _darkAppColors.onBackground,
    ),
  );
}
