import 'package:easy_gestion/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom({super.key, required this.icon, this.onPressed});
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final isDarkmode = CustomHelperFunctions.isDarkMode(context);
    return IconButton(
      style: IconButton.styleFrom(
          backgroundColor: isDarkmode ? CustomColors.dark : CustomColors.light),
      icon: Icon(Icons.arrow_back,
          color: isDarkmode ? Colors.white : Colors.black),
      onPressed: onPressed,
    );
  }
}
