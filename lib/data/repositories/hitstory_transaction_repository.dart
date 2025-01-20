import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_gestion/data/authentification.dart';
import 'package:easy_gestion/model/depense_model.dart';
import 'package:easy_gestion/model/produit_model.dart';
import 'package:easy_gestion/model/reaprovisionement_model.dart';
import 'package:easy_gestion/model/transaction_model.dart';
import 'package:easy_gestion/utils/loaders/firebase_exception.dart';
import 'package:get/get.dart';

class HistoryTransactionRepository extends GetxController {
  static HistoryTransactionRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String authUserId = AuthenticationRepository.instance.authUser!.uid;

  // Ajout d'une nouvelle transaction
  Future<void> addTransaction(ProductTransactionModel transaction) async {
    try {
      await _db
          .collection("Users")
          .doc(authUserId)
          .collection('product_transactions')
          .doc(transaction.id)
          .set(transaction.toMap());
      print('Transaction ajoutée avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de l\'ajout de la transaction';
    }
  }

  Future<void> addCommandes(CommanndeTransactionModel commande) async {
    try {
      await _db
          .collection("Users")
          .doc(authUserId)
          .collection('product_commandes')
          .doc(commande.id)
          .set(commande.toMap());
      print('commande ajoutée avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de l\'ajout de la transaction';
    }
  }

  Future<void> addDepenses(DepenseModel depense) async {
    try {
      await _db
          .collection("Users")
          .doc(authUserId)
          .collection('Depenses')
          .doc(depense.id)
          .set(depense.toMap());
      print('depense ajoutée avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de l\'ajout de la transaction';
    }
  }

  // Récupérer toutes les transactions et associer les produits
  Future<List<ProductTransactionModel>> fetchAllTransactions() async {
    try {
      final querySnapshot = await _db
          .collection("Users")
          .doc(authUserId)
          .collection('product_transactions')
          .orderBy('date', descending: true)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      List<ProductTransactionModel> transactions = [];

      for (var doc in querySnapshot.docs) {
        // Créer la transaction à partir du snapshot
        ProductTransactionModel transaction =
            ProductTransactionModel.fromSnapshot(doc);

        // Récupérer le produit associé
        ProduitModel product = await _getProductById(transaction.productId);

        // Ajouter le produit à la transaction
        transaction.product = product;

        // Ajouter la transaction à la liste
        transactions.add(transaction);
      }

      return transactions;
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la récupération des transactions';
    }
  }

  Future<List<CommanndeTransactionModel>> fetchAllCommmandes() async {
    try {
      final querySnapshot = await _db
          .collection("Users")
          .doc(authUserId)
          .collection('product_commandes')
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      List<CommanndeTransactionModel> commandes = [];

      for (var doc in querySnapshot.docs) {
        // Créer la transaction à partir du snapshot
        CommanndeTransactionModel commande =
            CommanndeTransactionModel.fromSnapshot(doc);

        // Récupérer le produit associé
        ProduitModel product = await _getProductById(commande.productId);

        // Ajouter le produit à la transaction
        commande.product = product;

        // Ajouter la transaction à la liste
        commandes.add(commande);
      }

      return commandes;
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la récupération des transactions';
    }
  }

  Future<List<DepenseModel>> fetchAllDepenses() async {
    try {
      final querySnapshot = await _db
          .collection("Users")
          .doc(authUserId)
          .collection('Depenses')
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }
      return querySnapshot.docs
          .map((doc) => DepenseModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la récupération des transactions';
    }
  }

  // Récupérer un produit par son ID
  Future<ProduitModel> _getProductById(String productId) async {
    try {
      final productDoc = await _db
          .collection("Users")
          .doc(authUserId)
          .collection('Produits')
          .doc(productId)
          .get();

      if (!productDoc.exists) {
        throw 'Produit introuvable';
      }

      return ProduitModel.fromSnapshot(productDoc);
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la récupération du produit';
    }
  }

  // Mettre à jour une  commande
  Future<void> updateCommande(
      String transactionId, Map<String, dynamic> updatedData) async {
    try {
      await _db
          .collection("Users")
          .doc(authUserId)
          .collection('product_commandes')
          .doc(transactionId)
          .update(updatedData);
      print('Transaction mise à jour avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la mise à jour de la transaction';
    }
  }

  // Mettre à jour une transaction
  Future<void> updateTransaction(
      String transactionId, Map<String, dynamic> updatedData) async {
    try {
      await _db
          .collection("Users")
          .doc(authUserId)
          .collection('product_transactions')
          .doc(transactionId)
          .update(updatedData);
      print('Transaction mise à jour avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la mise à jour de la transaction';
    }
  }

  // Mettre à jour une transaction
  Future<void> updateDepense(
      String depenseId, Map<String, dynamic> updatedData) async {
    try {
      await _db
          .collection("Users")
          .doc(authUserId)
          .collection('Depenses')
          .doc(depenseId)
          .update(updatedData);
      print('Transaction mise à jour avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la mise à jour de la transaction';
    }
  }

  // Supprimer une transaction
  Future<void> deleteTransaction(String transactionId) async {
    try {
      await _db
          .collection("Users")
          .doc(authUserId)
          .collection('product_transactions')
          .doc(transactionId)
          .delete();
      print('Transaction supprimée avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la suppression de la transaction';
    }
  }

  Future<void> deleteDepense(String depenseId) async {
    try {
      await _db
          .collection("Users")
          .doc(authUserId)
          .collection('Depenses')
          .doc(depenseId)
          .delete();
      print('Depenses supprimée avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la suppression de la transaction';
    }
  }

  // Supprimer une transaction
  Future<void> deleteCommande(String transactionId) async {
    try {
      await _db
          .collection("Users")
          .doc(authUserId)
          .collection('product_commandes')
          .doc(transactionId)
          .delete();
      print('Transaction supprimée avec succès');
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la suppression de la transaction';
    }
  }

  Stream<double> getTotalAmountStream() {
    return _db
        .collection("Users")
        .doc(authUserId)
        .collection('product_transactions')
        .snapshots()
        .map((querySnapshot) {
      double totalAmount = 0.0;
      for (var doc in querySnapshot.docs) {
        var transaction = ProductTransactionModel.fromSnapshot(doc);
        totalAmount += transaction.totalAmount;
      }
      return totalAmount;
    });
  }

  Stream<double> getTotalAmountCommandeStream() {
    return _db
        .collection("Users")
        .doc(authUserId)
        .collection('product_commandes')
        .snapshots()
        .map((querySnapshot) {
      double totalAmount = 0.0;
      for (var doc in querySnapshot.docs) {
        var commandes = CommanndeTransactionModel.fromSnapshot(doc);
        totalAmount += commandes.totalAmount;
      }
      return totalAmount;
    });
  }

  Stream<double> getTotalAmountDepensesStream() {
    return _db
        .collection("Users")
        .doc(authUserId)
        .collection('Depenses')
        .snapshots()
        .map((querySnapshot) {
      double totalAmount = 0.0;
      for (var doc in querySnapshot.docs) {
        var depense = DepenseModel.fromSnapshot(doc);
        totalAmount += depense.totalAmount;
      }
      return totalAmount;
    });
  }

  // Sommation du montant total des transactions
}
