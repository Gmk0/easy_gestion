import 'package:intl/intl.dart';

class CFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy')
        .format(date); // Personnaliser le format de la date si nécessaire
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(
        amount); // Personnaliser la locale et le symbole de la devise si nécessaire
  }

  static String formatPhoneNumber(String phoneNumber) {
    // En supposant un format de numéro de téléphone américain à 10 chiffres : (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7)}';
    }

    // Ajouter plus de logique de formatage de numéro de téléphone personnalisée pour différents formats si nécessaire.
    return phoneNumber;
  }

  // Pas complètement testé.
  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Supprimer tous les caractères non numériques du numéro de téléphone
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extraire l'indicatif du pays des chiffres uniquement
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Ajouter les chiffres restants avec le bon formatage
    final formattedNumber = StringBuffer();
    formattedNumber.write('$countryCode ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    return formattedNumber.toString();
  }
}
