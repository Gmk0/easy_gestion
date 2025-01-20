import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';

class TabBarCustom extends StatelessWidget implements PreferredSizeWidget {
  /// If you want to add the background color to tabs you have to wrap them in Material widget.
  /// To do that we need [PreferredSize] widget and that's why created custom class. [PreferredSize]
  const TabBarCustom({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: dark ? CustomColors.black : CustomColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: false,
        indicatorColor: CustomColors.futaColor,
        labelColor: dark ? CustomColors.white : CustomColors.futaColor,
        unselectedLabelColor: CustomColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(CustomDeviceUtils.getAppBarHeight());
}
