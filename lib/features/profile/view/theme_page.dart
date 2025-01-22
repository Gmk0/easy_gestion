import 'package:easy_gestion/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  // Valeur initiale définie sur 'Système'

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thème'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choisir un thème',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('Clair'),
                  leading: Radio<ThemeMode>(
                    value: ThemeMode.light,
                    groupValue: themeController.themeMode.value,
                    onChanged: (val) {
                      themeController.setThemeMode(ThemeMode.light);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Sombre'),
                  leading: Radio<ThemeMode>(
                    value: ThemeMode.dark,
                    groupValue: themeController.themeMode.value,
                    onChanged: (val) {
                      themeController.setThemeMode(ThemeMode.dark);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Système'),
                  leading: Radio<ThemeMode>(
                    value: ThemeMode.system,
                    groupValue: themeController.themeMode.value,
                    onChanged: (val) {
                      themeController.setThemeMode(ThemeMode.system);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
