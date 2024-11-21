import 'package:flutter/material.dart'
    show BuildContext, Locale, Size, StatelessWidget, Widget;
import 'package:flutter_screenutil/flutter_screenutil.dart' show ScreenUtilInit;
import 'package:get/get.dart' show GetMaterialApp;
import 'package:monito/app/core/languages/languages.dart';
import 'package:monito/app/core/values/theme_controller.dart';
import 'package:monito/app/modules/intro/bindings/splash_binding.dart';

import 'core/routes/pages.dart';
import 'core/values/theme.dart';

class Monito extends StatelessWidget {
  const Monito({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppLanguages(),
        locale: const Locale('fa'),
        title: 'Monito',
        themeMode: ThemeController.instance.theme,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        initialRoute: AppRoutes.splash,
        initialBinding: SplashBinding(),
        getPages: AppPages.pages,
      ),
    );
  }
}
