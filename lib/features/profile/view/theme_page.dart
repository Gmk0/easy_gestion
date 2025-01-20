import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  // Valeur initiale définie sur 'Système'
  String _themeChoice = 'System';

  void _changeTheme(String value) {
    setState(() {
      _themeChoice = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thème'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choisir un thème',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Clair'),
              leading: Radio<String>(
                value: 'Light',
                groupValue: _themeChoice,
                onChanged: (val) {
                  _changeTheme(val!);
                },
              ),
            ),
            ListTile(
              title: const Text('Sombre'),
              leading: Radio<String>(
                value: 'Dark',
                groupValue: _themeChoice,
                onChanged: (val) {
                  _changeTheme(val!);
                },
              ),
            ),
            ListTile(
              title: const Text('Système'),
              leading: Radio<String>(
                value: 'System',
                groupValue: _themeChoice,
                onChanged: (val) {
                  _changeTheme(val!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
