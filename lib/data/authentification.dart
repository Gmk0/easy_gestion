import 'package:easy_gestion/features/auth/view/login_screen.dart';
import 'package:easy_gestion/features/navigation/nav_screen.dart';
import 'package:easy_gestion/features/onBoarding/view/on_boarding_screen.dart';
import 'package:easy_gestion/utils/loaders/firebase_exception.dart';

import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    // Supprime l'écran de démarrage natif
    //FlutterNativeSplash.remove();

    // Redirection de l'écran selon l'état de l'utilisateur
    screenRedirect();
  }

  // Redirige l'utilisateur en fonction de son état de connexion et de vérification
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Si l'utilisateur est connecté mais son e-mail n'est pas vérifié ca doit etre a true plutot
      if (user.email != null) {
        Get.offAll(() => const NavigationMenu());
      } else {
        // Si l'utilisateur est connecté et son e-mail est vérifié
      }
    } else {
      // Si l'utilisateur n'est pas connecté
      deviceStorage.writeIfNull('isFirsTime', true);
      deviceStorage.read('isFirsTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => OnboardingScreen());
    }
  }

  //connexion de l'utilisateur

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException;
    } on PlatformException catch (e) {
      throw TPlatformException;
    } catch (e) {
      throw 'Une erreur est survenue';
    }
  }

  // Inscription avec e-mail et mot de passe
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException;
    } on PlatformException catch (e) {
      throw TPlatformException;
    } catch (e) {
      throw 'Une erreur est survenue';
    }
  }

  // Envoi de l'e-mail de vérification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException;
    } on PlatformException catch (e) {
      throw TPlatformException;
    } catch (e) {
      throw 'Une erreur est survenue';
    }
  }

  // Envoi password reset
  Future<void> sendEmailPasswordRest(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException;
    } on PlatformException catch (e) {
      throw TPlatformException;
    } catch (e) {
      throw 'Une erreur est survenue';
    }
  }

  // Déconnexion de l'utilisateur
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance?.signOut();
      //  await GoogleSignIn()!.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException;
    } on PlatformException catch (e) {
      throw TPlatformException;
    } catch (e) {
      throw 'Une erreur est survenue';
    }
  }

  //connexion avec google

  /*

  Future<UserCredential> signiWithGoole() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException;
    } on PlatformException catch (e) {
      print(e.message);
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreur est survenue';
    }
  }
  */

  Future<UserCredential> reAuthenticationWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      return await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException;
    } on PlatformException catch (e) {
      print(e.message);
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreur est survenue';
    }
  }

  // Déconnexion de l'utilisateur
  Future<void> deleteAccount() async {
    try {
      // await UserRepository.Instance.removeRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException;
    } on PlatformException catch (e) {
      throw TPlatformException;
    } catch (e) {
      throw 'Une erreur est survenue';
    }
  }

  // Déconnexion de l'utilisateur
}
