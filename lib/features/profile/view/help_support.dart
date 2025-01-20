import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aide et Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'FAQ (Questions fréquentes)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFAQItem(
                question: 'Comment utiliser l\'application ?',
                answer:
                    'Il suffit de vous connecter et d\'explorer les fonctionnalités.'),
            _buildFAQItem(
                question: 'Comment réinitialiser mon mot de passe ?',
                answer:
                    'Allez dans la section "Profil" et cliquez sur "Réinitialiser le mot de passe".'),
            const Divider(),
            const Text(
              'Formulaire de Contact',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Si vous avez des questions ou des problèmes, vous pouvez nous contacter via ce formulaire.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logique pour envoyer le message
              },
              child: const Text('Envoyer le message'),
            ),
            const Divider(),
            const Text(
              'Informations sur l\'application',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Version 1.0.0\nDéveloppé par pro create.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return ListTile(
      title:
          Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(answer),
    );
  }
}
