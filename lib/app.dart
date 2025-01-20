import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:easy_gestion/bindings/general_binding.dart';
import 'package:easy_gestion/features/onBoarding/view/on_boarding_screen.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Easy gestion',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.dartTheme,
      initialBinding: GeneralBindings(),
      home: Scaffold(
        body: Container(
          height: double.infinity,
          color: Colors.white,
          child: const Center(
            child: Image(
              width: CustomSize.iconsMd,
              height: CustomSize.iconsMd,
              image: AssetImage(CustomImage.logoApp),
            ),
          ),
        ),
      ),
    );
  }
}
