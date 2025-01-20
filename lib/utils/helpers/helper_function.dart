import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomHelperFunctions {
  // Retourne la couleur correspondant à la valeur donnée
  static Color? getColor(String value) {
    /// Définissez vos couleurs spécifiques aux produits ici et cela correspondra aux couleurs des attributs et affichera des couleurs spécifiques
    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    }
    return null;
  }

  static String functionGetColors(Color color) {
    switch (color) {
      case Colors.red:
        return "Red";
      case Colors.green:
        return "Green";
      case Colors.blue:
        return "Blue";
      default:
        return "Green"; // Or handle it as needed
    }
  }

  static NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'fr_FR',
    symbol: 'CDF ', // Le symbole de la monnaie
  );

  static Color statusColorTraitement(String status) {
    switch (status) {
      case 'En cours de traitement':
        return Colors.red;
      case 'En transit':
        return Colors.blue;
      case 'Livré':
        return Colors.green;
      case 'En attente':
        return Colors.yellow;
      case 'Reussie':
        return Colors.green;
      case 'completed':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  // Retourne la largeur de l'écran
  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  // Retourne la date formatée
  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  // Supprime les doublons dans une liste
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  // Organise les widgets en lignes de la taille spécifiée
  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  // Vérifie si le mode sombre est activé
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Retourne la taille de l'écran
  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  // Retourne la hauteur de l'écran
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  // Affiche un SnackBar avec le message donné
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Affiche une alerte avec le titre et le message donnés
  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Navigue vers un autre écran
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // Troncature du texte si sa longueur dépasse la longueur maximale spécifiée
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}
