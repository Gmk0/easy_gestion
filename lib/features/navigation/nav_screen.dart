import 'package:easy_gestion/features/navigation/controller/navigation_controller.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = CustomHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => NavigationBar(
              height: 70,
              elevation: 0,
              backgroundColor:
                  darkMode ? CustomColors.dark : CustomColors.light,
              indicatorColor: darkMode
                  ? CustomColors.white.withAlpha(2)
                  : CustomColors.black.withAlpha(1),
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: const [
                NavigationDestination(
                    icon: Icon(Iconsax.home), label: 'Accueil'),
                NavigationDestination(
                  icon: Icon(Iconsax.card),
                  label: 'Transaction',
                ),
                NavigationDestination(
                    icon: Icon(Iconsax.chart), label: 'Produit'),
                NavigationDestination(
                    icon: Icon(Iconsax.user), label: 'profile'),
              ])),
    );
  }
}
