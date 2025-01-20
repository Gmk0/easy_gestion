// Définition de la classe d'exception personnalisée

class TFirebaseAuthException implements Exception {
  /// Le code d'erreur associé à l'exception.
  final String code;

  /// Constructeur qui prend un code d'erreur.
  TFirebaseAuthException(this.code);

  /// Obtient le message d'erreur correspondant basé sur le code d'erreur.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return "L'adresse e-mail est déjà utilisée. Veuillez utiliser une autre adresse e-mail.";
      case 'invalid-email':
        return "L'adresse e-mail fournie est invalide. Veuillez saisir une adresse e-mail valide.";
      case 'weak-password':
        return "Le mot de passe est trop faible. Veuillez choisir un mot de passe plus fort.";
      case 'user-disabled':
        return "Ce compte utilisateur a été désactivé. Veuillez contacter l'assistance pour obtenir de l'aide.";
      case 'user-not-found':
        return "Détails de connexion invalides. Utilisateur non trouvé.";
      case 'wrong-password':
        return "Mot de passe incorrect. Veuillez vérifier votre mot de passe et réessayer.";
      case 'invalid-verification-code':
        return "Code de vérification invalide. Veuillez saisir un code valide.";
      case 'invalid-verification-id':
        return "ID de vérification invalide. Veuillez demander un nouveau code de vérification.";
      case 'quota-exceeded':
        return "Quota dépassé. Veuillez réessayer plus tard.";
      case 'email-already-exists':
        return "L'adresse e-mail existe déjà. Veuillez utiliser une autre adresse e-mail.";
      case 'credential-already-linked':
        return "Le compte est déjà lié à un autre fournisseur.";
      case 'operation-not-allowed':
        return "Cette opération n'est pas autorisée. Veuillez contacter l'assistance.";
      case 'invalid-credential':
        return "Informations d'identification invalides. Veuillez vérifier et réessayer.";
      case 'network-request-failed':
        return "La demande réseau a échoué. Veuillez vérifier votre connexion Internet et réessayer.";
      case 'user-token-expired':
        return "Le jeton d'utilisateur a expiré. Veuillez vous reconnecter.";
      case 'too-many-requests':
        return "Trop de demandes. Veuillez réessayer plus tard.";
      case 'requires-recent-login':
        return "Cette opération nécessite une connexion récente. Veuillez vous reconnecter et réessayer.";
      case 'account-exists-with-different-credential':
        return "Un compte existe déjà avec des informations d'identification différentes.";
      case 'auth-domain-config-required':
        return "La configuration du domaine d'authentification est requise.";
      case 'cancelled-popup-request':
        return "La demande de popup a été annulée.";
      case 'captcha-check-failed':
        return "La vérification CAPTCHA a échoué.";
      case 'expired-action-code':
        return "Le code d'action a expiré. Veuillez demander un nouveau code.";
      case 'invalid-action-code':
        return "Le code d'action est invalide. Veuillez vérifier et réessayer.";
      case 'unauthorized-domain':
        return "Domaine non autorisé. Veuillez vérifier la configuration de votre domaine.";
      case 'invalid-api-key':
        return "Clé API invalide. Veuillez vérifier et réessayer.";
      case 'invalid-user-token':
        return "Jeton utilisateur invalide. Veuillez vous reconnecter.";
      case 'missing-android-pkg-name':
        return "Nom du package Android manquant.";
      case 'missing-continue-uri':
        return "URI de continuation manquant.";
      case 'missing-ios-bundle-id':
        return "ID de bundle iOS manquant.";
      case 'invalid-continue-uri':
        return "URI de continuation invalide.";
      case 'invalid-email-verified':
        return "Adresse e-mail de vérification invalide.";
      case 'missing-verify-phone-number':
        return "Numéro de téléphone de vérification manquant.";
      case 'invalid-phone-number':
        return "Numéro de téléphone invalide.";
      case 'missing-phone-code':
        return "Code de téléphone manquant.";
      case 'invalid-phone-code':
        return "Code de téléphone invalide.";
      case 'missing-iframe-start':
        return "Le modèle d'e-mail manque de la balise de début d'iframe.";
      case 'missing-iframe-end':
        return "Le modèle d'e-mail manque de la balise de fin d'iframe.";
      case 'missing-iframe-src':
        return "Le modèle d'e-mail manque de l'attribut src de l'iframe.";
      case 'missing-app-credential':
        return "L'identifiant de l'application est manquant. Veuillez fournir des informations d'identification valides.";
      case 'session-cookie-expired':
        return "Le cookie de session Firebase a expiré. Veuillez vous reconnecter.";
      case 'uuid-already-exists':
        return "L'ID utilisateur fourni est déjà utilisé par un autre utilisateur.";
      case 'web-storage-unsupported':
        return "Le stockage web n'est pas pris en charge ou est désactivé.";
      case 'app-deleted':
        return "Cette instance de FirebaseApp a été supprimée.";
      case 'user-token-mismatch':
        return "Le jeton de l'utilisateur fourni ne correspond pas à l'ID de l'utilisateur authentifié.";
      case 'invalid-message-payload':
        return "La charge utile du message de vérification par e-mail est invalide.";
      case 'invalid-sender':
        return "L'expéditeur du modèle d'e-mail est invalide. Veuillez vérifier l'adresse e-mail de l'expéditeur.";
      case 'invalid-recipient-email':
        return "L'adresse e-mail du destinataire est invalide. Veuillez fournir une adresse e-mail de destinataire valide.";
      default:
        return "Une erreur indéfinie est survenue. Veuillez réessayer.";
    }
  }
}

class TPlatformException implements Exception {
  /// Le code d'erreur associé.
  final String code;

  /// Constructeur prenant un code d'erreur.
  TPlatformException(this.code);

  /// Obtient le message d'erreur correspondant basé sur le code d'erreur.
  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return "Identifiants de connexion invalides. Veuillez vérifier vos informations.";
      case 'too-many-requests':
        return "Trop de requêtes. Veuillez réessayer plus tard.";
      case 'invalid-argument':
        return "Argument invalide fourni à la méthode d'authentification.";
      case 'invalid-password':
        return "Mot de passe incorrect. Veuillez réessayer.";
      case 'invalid-phone-number':
        return "Le numéro de téléphone fourni est invalide.";
      case 'operation-not-allowed':
        return "Le fournisseur de connexion est désactivé pour votre projet Firebase.";
      case 'session-cookie-expired':
        return "Le cookie de session Firebase a expiré. Veuillez vous reconnecter.";
      case 'uid-already-exists':
        return "L'ID utilisateur fourni est déjà utilisé par un autre utilisateur.";
      case 'sign-in-failed':
        return "La connexion a échoué. Veuillez réessayer.";
      case 'network-request-failed':
        return "La requête réseau a échoué. Veuillez vérifier votre connexion Internet.";
      case 'internal-error':
        return "Erreur interne. Veuillez réessayer plus tard.";
      case 'invalid-verification-code':
        return "Code de vérification invalide. Veuillez saisir un code valide.";
      case 'invalid-verification-id':
        return "ID de vérification invalide. Veuillez demander un nouveau code de vérification.";
      case 'quota-exceeded':
        return "Quota dépassé. Veuillez réessayer plus tard.";
      case 'account-exists-with-different-credential':
        return "Un compte existe déjà avec des informations d'identification différentes.";
      case 'missing-iframe-start':
        return "Le modèle d'e-mail manque la balise de début d'iframe.";
      case 'missing-iframe-end':
        return "Le modèle d'e-mail manque la balise de fin d'iframe.";
      case 'missing-iframe-src':
        return "Le modèle d'e-mail manque l'attribut src de l'iframe.";
      case 'auth-domain-config-required':
        return "La configuration du domaine d'authentification est requise.";
      case 'missing-app-credential':
        return "L'identifiant de l'application est manquant. Veuillez fournir des informations d'identification valides.";
      case 'uuid-already-exists':
        return "L'ID utilisateur fourni est déjà utilisé par un autre utilisateur.";
      case 'web-storage-unsupported':
        return "Le stockage web n'est pas pris en charge ou est désactivé.";
      case 'app-deleted':
        return "Cette instance de FirebaseApp a été supprimée.";
      case 'user-token-mismatch':
        return "Le jeton de l'utilisateur fourni ne correspond pas à l'ID de l'utilisateur authentifié.";
      case 'invalid-message-payload':
        return "La charge utile du message de vérification par e-mail est invalide.";
      case 'invalid-sender':
        return "L'expéditeur du modèle d'e-mail est invalide. Veuillez vérifier l'adresse e-mail de l'expéditeur.";
      case 'invalid-recipient-email':
        return "L'adresse e-mail du destinataire est invalide. Veuillez fournir une adresse e-mail de destinataire valide.";
      case 'invalid-continue-uri':
        return "L'URI de continuation est invalide.";
      case 'missing-continue-uri':
        return "L'URI de continuation est manquant.";
      case 'missing-ios-bundle-id':
        return "L'ID de bundle iOS est manquant.";
      case 'missing-android-pkg-name':
        return "Le nom du package Android est manquant.";
      case 'invalid-api-key':
        return "Clé API invalide.";
      case 'invalid-user-token':
        return "Jeton utilisateur invalide. Veuillez vous reconnecter.";
      case 'unauthorized-domain':
        return "Domaine non autorisé. Veuillez vérifier la configuration de votre domaine.";
      case 'invalid-credential':
        return "Informations d'identification invalides.";
      default:
        return "Une erreur inconnue est survenue. Veuillez réessayer.";
    }
  }
}

class TFormatException implements Exception {
  /// Le message d'erreur associé.
  final String message;

  /// Constructeur par défaut avec un message d'erreur générique.
  const TFormatException(
      [this.message =
          'Une erreur de format inattendue est survenue. Veuillez vérifier votre entrée.']);

  /// Crée une exception de format à partir d'un message d'erreur spécifique.
  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  /// Obtient le message d'erreur correspondant.
  String get formattedMessage => message;

  /// Crée une exception de format à partir d'un code d'erreur spécifique.
  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const TFormatException(
            'Le format de l\'adresse e-mail est invalide. Veuillez saisir un e-mail valide.');
      case 'invalid-phone-number-format':
        return const TFormatException(
            'Le format du numéro de téléphone fourni est invalide. Veuillez saisir un numéro valide.');
      case 'invalid-date-format':
        return const TFormatException(
            'Le format de la date est invalide. Veuillez saisir une date valide.');
      case 'invalid-url-format':
        return const TFormatException(
            'Le format de l\'URL est invalide. Veuillez saisir une URL valide.');
      case 'invalid-credit-card-format':
        return const TFormatException(
            'Le format de la carte de crédit est invalide. Veuillez saisir un numéro de carte de crédit valide.');
      case 'invalid-numeric-format':
        return const TFormatException(
            'L\'entrée doit être un format numérique valide.');
      // Ajoutez plus de cas si nécessaire...
      default:
        return const TFormatException();
    }
  }
}

class TFirebaseException implements Exception {
  final String code;
  late String message;

  TFirebaseException(this.code) {
    switch (code) {
      case 'invalid-email':
        message = 'L\'adresse e-mail n\'est pas valide.';
        break;
      case 'user-disabled':
        message = 'Cet utilisateur a été désactivé.';
        break;
      case 'user-not-found':
        message = 'Aucun utilisateur trouvé avec cette adresse e-mail.';
        break;
      case 'wrong-password':
        message = 'Le mot de passe est incorrect.';
        break;
      default:
        message = 'Une erreur inconnue s\'est produite de firebase. $code';
        break;
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
