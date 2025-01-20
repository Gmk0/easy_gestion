class CustomValidator {
  // Valide le numéro de téléphone

  static String? validatorEmptytext(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return 'le champ $fieldName est requis';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le numéro de téléphone est requis.';
    }

    // Expression régulière pour la validation du numéro de téléphone (en supposant un format de numéro de téléphone américain à 10 chiffres)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Format de numéro de téléphone invalide (10 chiffres requis).';
    }

    return null;
  }

  // Valide l'email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est requis.';
    }

    // Expression régulière pour la validation des emails
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Adresse email invalide.';
    }

    return null;
  }

  // Valide le mot de passe
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis.';
    }

    // Vérifie la longueur minimale du mot de passe
    if (value.length < 6) {
      return 'Le mot de passe doit comporter au moins 6 caractères.';
    }

    // Vérifie les lettres majuscules
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Le mot de passe doit contenir au moins une lettre majuscule.';
    }

    // Vérifie les chiffres
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Le mot de passe doit contenir au moins un chiffre.';
    }

    // Vérifie les caractères spéciaux
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Le mot de passe doit contenir au moins un caractère spécial.';
    }

    return null;
  }
}
