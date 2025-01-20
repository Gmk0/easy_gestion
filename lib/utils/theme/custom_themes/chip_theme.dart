import 'package:easy_gestion/utils/constants/colors.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';

class CustomChipTheme {
  CustomChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: CustomColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: CustomColors.futaColor,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );
  static ChipThemeData darktChipTheme = const ChipThemeData(
    disabledColor: CustomColors.darkerGrey,
    labelStyle: TextStyle(color: Colors.white),
    selectedColor: CustomColors.futaColor,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );
}
