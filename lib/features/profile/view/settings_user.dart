import 'package:easy_gestion/features/profile/view/help_support.dart';
import 'package:easy_gestion/features/profile/view/profile_user.dart';
import 'package:easy_gestion/features/profile/view/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListSettings(
            label: 'Profile',
            icon: Icons.person,
            action: () => Get.to(() => ProfilePage()),
          ),
          const Divider(),
          ListSettings(
            label: 'Thème',
            icon: Icons.brightness_6,
            action: () => Get.to(() => ThemePage()),
          ),
          const Divider(),
          ListSettings(
            label: 'Aide et Support',
            icon: Icons.help,
            action: () => Get.to(() => HelpPage()),
          ),
          const Divider(),
          ListTile(
            title: const Text('Déconnexion'),
            leading: const Icon(Icons.logout),
            onTap: () {
              // Logic for logout
            },
          ),
          const Divider(),
          const ListTile(
            title: Text('Version de l\'application'),
            leading: Icon(Icons.info),
            trailing: Text('1.0.0'), // Remplace par la version actuelle
          ),
        ],
      ),
    );
  }
}

class ListSettings extends StatelessWidget {
  const ListSettings({
    super.key,
    required this.label,
    required this.icon,
    this.action,
  });

  final String label;
  final IconData icon;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: ListTile(
        title: Text(label),
        leading: Icon(icon),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
