import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:easy_gestion/bindings/general_binding.dart';
import 'package:easy_gestion/features/onBoarding/view/on_boarding_screen.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/theme/theme.dart';
import 'package:easy_gestion/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    final ThemeController themeController = Get.put(ThemeController());
    return Obx(() {
      return GetMaterialApp(
        title: 'Easy gestion',
        debugShowCheckedModeBanner: false,
        // locale: DevicePreview.locale(context),
        locale: const Locale('fr', 'FR'), // Locale par défaut : Français
        fallbackLocale: const Locale('fr', 'FR'),
        builder: DevicePreview.appBuilder,
        themeMode: themeController.themeMode.value,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.dartTheme,
        initialBinding: GeneralBindings(),
        home: Scaffold(
          body: Container(
            height: double.infinity,
            color: dark ? Colors.black : Colors.white,
            child: Center(
              child: Lottie.asset(CustomImage.animation,
                  width: MediaQuery.of(context).size.width * 0.3),
            ),
          ),
        ),
      );
    });
  }
}
