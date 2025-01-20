import 'package:easy_gestion/features/onBoarding/produit/view/home.dart';
import 'package:easy_gestion/features/onBoarding/view/home/view/home.dart';
import 'package:easy_gestion/features/profile/view/profile_user.dart';
import 'package:easy_gestion/features/profile/view/settings_user.dart';
import 'package:easy_gestion/features/transaction/view/liste_transaction.dart';

import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const ListeTransaction(),
    const HomeProduit(),
    const SettingsPage(),
  ];
}
