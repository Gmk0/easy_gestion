import 'package:easy_gestion/utils/constants/colors.dart';
import 'package:easy_gestion/utils/helpers/helper_function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_gestion/utils/export.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;
  final Function? onPressed;
  final bool leading;
  final bool action;
  final List<Widget>? actions;
  const AppBarCustom(
      {super.key,
      required this.title,
      this.icon,
      this.onPressed,
      this.leading = false,
      this.action = true,
      this.actions});

  @override
  Widget build(BuildContext context) {
    final isDarkmode = CustomHelperFunctions.isDarkMode(context);
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: leading
          ? IconButton(
              style: IconButton.styleFrom(
                  backgroundColor:
                      isDarkmode ? CustomColors.dark : CustomColors.light),
              icon: Icon(Icons.arrow_back,
                  color: isDarkmode ? Colors.white : Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
