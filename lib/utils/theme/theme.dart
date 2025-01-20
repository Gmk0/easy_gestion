import 'package:easy_gestion/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:easy_gestion/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:easy_gestion/utils/theme/custom_themes/chip_theme.dart';
import 'package:easy_gestion/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:easy_gestion/utils/theme/custom_themes/outline_buttom_theme.dart';
import 'package:easy_gestion/utils/theme/custom_themes/text_themes.dart';
import 'package:flutter/material.dart';

import 'custom_themes/app_bar_theme.dart';
import 'custom_themes/text_field_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextThemeCustom.lightTextTheme,
      chipTheme: CustomChipTheme.lightChipTheme,
      appBarTheme: AppBarThemeC.lightAppBarTheme,
      checkboxTheme: CheckboxThemeC.lightCheckBoxTheme,
      bottomSheetTheme: BottomSheetThemeC.lightBottomSheetTheme,
      elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: OutlineButtomThemeC.lightOutlinedButtonTheme,
      inputDecorationTheme: TextFieldThemeC.lightInputDecorationTheme);
  static ThemeData dartTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextThemeCustom.darkTextTheme,
      chipTheme: CustomChipTheme.darktChipTheme,
      appBarTheme: AppBarThemeC.darkAppBarTheme,
      checkboxTheme: CheckboxThemeC.darkCheckBoxTheme,
      bottomSheetTheme: BottomSheetThemeC.darkBottomSheetTheme,
      elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: OutlineButtomThemeC.darkOutlinedButtonTheme,
      inputDecorationTheme: TextFieldThemeC.darkInputDecorationTheme);
}
