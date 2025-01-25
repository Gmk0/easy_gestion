import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:easy_gestion/common/widgets/loader_class.dart';
import 'package:easy_gestion/data/authentification.dart';
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
          ListSettings(
            label: 'Supprimer le compte',
            icon: Icons.help,
            action: () async {
              await AuthenticationRepository.instance.deleteAccount();

              // Logic for logout
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Déconnexion'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await AuthenticationRepository.instance.logout();

              // Logic for logout
            },
          ),
          const Divider(),
          ListTile(
            title: Text('Version de l\'application'),
            leading: Icon(Icons.info),
            trailing: Text('1.0.0'), // Remplace par la version actuelle
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('À propos de l\'application'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nom de l\'application : Easy Gestion'),
                      SizedBox(height: 8),
                      Text(
                          'Version actuelle : 1.0.0'), // Remplace par une valeur dynamique si nécessaire
                      SizedBox(height: 8),
                      Text('Créateur : Pro create'),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Logique pour vérifier les mises à jour
                          Navigator.pop(
                              context); // Ferme le dialogue après l'action
                          _checkForUpdates(false);
                        },
                        icon: Icon(Icons.update),
                        label: Text('Vérifier les mises à jour'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Fermer'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _checkForUpdates(bool isUpdateAvailable) {
    // Simule une vérification de mise à jour
    //bool isUpdateAvailable; // Remplacez par une vérification réelle.

    if (isUpdateAvailable) {
      TLoaders.warningSnackBar(
          title: 'Mise à jour disponible',
          message:
              "Une nouvelle version est disponible. Veuillez la télécharger.");
    } else {
      TLoaders.warningSnackBar(
          title: 'À jour', message: "Vous utilisez la dernière version.");
    }
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
