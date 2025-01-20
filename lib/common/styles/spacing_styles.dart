import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';

class CustomSpacingStyle {
  static EdgeInsetsGeometry paddingWithAppBarHeight = const EdgeInsets.only(
    top: CustomSize.appBarHeight,
    left: CustomSize.defaultSpace,
    bottom: CustomSize.defaultSpace,
    right: CustomSize.defaultSpace,
  );
}
