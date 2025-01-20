import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_gestion/data/authentification.dart';
import 'package:easy_gestion/model/produit_model.dart';
import 'package:easy_gestion/utils/loaders/firebase_exception.dart';
import 'package:get/get.dart';

class ProduitRepository extends GetxController {
  static ProduitRepository get Instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserProduit(ProduitModel produit, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Produits')
          .doc(produit.id)
          .set(produit.toMap());
    } on FirebaseException catch (e) {
      print('ici');
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong; please try again';
    }
  }

  Future<List<ProduitModel>> fetchProduitDetails() async {
    try {
      final querySnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Produits")
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs
          .map((doc) => ProduitModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong; please try again';
    }
  }

  Future<void> updateProduit(
      String produitId, Map<String, dynamic> updatedData) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Produits")
          .doc(produitId)
          .update(updatedData);
      print('Produit mis à jour avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la mise à jour du produit';
    }
  }

  Future<void> deleteProduit(String produitId) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Produits")
          .doc(produitId)
          .delete();
      print('Produit supprimé avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la suppression du produit';
    }
  }

  Future<void> updateProduitQuantity(String produitId, double delta) async {
    try {
      final produitRef = _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Produits")
          .doc(produitId);

      await _db.runTransaction((transaction) async {
        final produitSnapshot = await transaction.get(produitRef);
        if (!produitSnapshot.exists) {
          throw Exception('Le produit n\'existe pas');
        }

        final currentQuantity = produitSnapshot.data()?['quantity'] ?? 0;
        final newQuantity = currentQuantity + delta;

        transaction.update(produitRef, {'quantity': newQuantity});
      });

      print('Quantité mise à jour avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      // throw 'Une erreur s\'est produite lors de la mise à jour de la quantité';
    }
  }
}
