import 'package:easy_gestion/common/widgets/loader_class.dart';

import 'package:easy_gestion/data/repositories/hitstory_transaction_repository.dart';
import 'package:easy_gestion/data/repositories/produit_repository.dart';
import 'package:easy_gestion/features/onBoarding/produit/controller/get_product_controller.dart';
import 'package:easy_gestion/features/onBoarding/view/home/controller/home_controller.dart';
import 'package:easy_gestion/features/transaction/controller/transaction_controller.dart';
import 'package:easy_gestion/model/produit_model.dart';
import 'package:easy_gestion/model/reaprovisionement_model.dart';

import 'package:easy_gestion/model/transaction_model.dart';
import 'package:easy_gestion/utils/constants/image_strings.dart';
import 'package:easy_gestion/utils/popups/full_screen_loader.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

class CommandesController extends GetxController {
  final produitId = TextEditingController();
  final quantity = TextEditingController();
  final commandeesPrice = TextEditingController();

  var dateTime = DateTime.now().obs;

  RxBool isLoading = false.obs;

  GlobalKey<FormState> commandesForm = GlobalKey<FormState>();

  RxList<ProduitModel> produits =
      <ProduitModel>[].obs; // Liste de produits de type ProduitModel

  @override
  void onInit() {
    super.onInit();
    fetchProduits();
  }

  void clear() {
    commandeesPrice.text = "";
    quantity.text = "";
  }

  void initController(CommanndeTransactionModel commande) {
    commandeesPrice.text = commande.totalAmount.toString();
    quantity.text = commande.quantity.toString();
    produitId.text = commande.productId;
  }

  Future<void> fetchProduits() async {
    try {
      final produitController = ProduitController.Instance;
      final fetchedProduits = produitController.produits;

      produits.value =
          fetchedProduits; // Mettre à jour la liste avec les produits récupérés
    } catch (e) {
      print('Erreur lors de la récupération des produits: $e');
    }
  }

  Future<void> addCommandes() async {
    try {
      //final isConnected = await NetworkManager.instance.isConnected();

      if (!commandesForm.currentState!.validate()) {
        TLoaders.warningSnackBar(
            title: 'veuillez remplier tout les elements',
            message: 'In order to create acount');
        return;
      }

      //Register user in tehe firebase authentication
      var uuid = Uuid();

      final commandes = CommanndeTransactionModel(
        id: uuid.v4(),
        productId: produitId.text,
        date: dateTime.value,
        quantity: double.parse(quantity.text),
        totalAmount: double.parse(commandeesPrice.text),
      );

      final transactionRepo = HistoryTransactionRepository.instance;
      final produitRepository = ProduitRepository.Instance;

      final produitController = ProduitController.Instance;

      await transactionRepo.addCommandes(commandes);

      produitRepository.updateProduitQuantity(
          produitId.text, double.parse(quantity.text));

      await produitController.fetchProduits();

      if (Get.isRegistered<TransactionController>()) {
        final transactionController = TransactionController.Instance;
        transactionController.fetchAllCommandes();

        // Le Controller est déjà enregistré
        print("Le Controller est déjà créé.");
      }

      clear();

      // await transactionRepo.getTotalAmount();

      //remove loader

      // TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Congratulations!',
          message: 'Transaction ajouter avec succees');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editCommandes(CommanndeTransactionModel commande) async {
    try {
      //final isConnected = await NetworkManager.instance.isConnected();

      if (!commandesForm.currentState!.validate()) {
        TLoaders.warningSnackBar(
            title: 'veuillez remplier tout les elements',
            message: 'In order to create acount');
        return;
      }

      var data = {
        'quantity': double.parse(quantity.text),
        'totalAmount': double.parse(commandeesPrice.text),
      };

      var qty = -(commande.quantity) + double.parse(quantity.text);

      final transactionRepo = HistoryTransactionRepository.instance;
      final produitRepository = ProduitRepository.Instance;

      final produitController = ProduitController.Instance;

      await transactionRepo.updateCommande(commande.id, data);

      produitRepository.updateProduitQuantity(produitId.text, qty);
      final transactionController = TransactionController.Instance;

      await produitController.fetchProduits();

      transactionController.fetchAllCommandes();

      clear();

      // await transactionRepo.getTotalAmount();

      Get.back();
      //remove loader

      // TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Congratulations!',
          message: 'Transaction ajouter avec succees');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCommandes(CommanndeTransactionModel commande) async {
    try {
      //final isConnected = await NetworkManager.instance.isConnected();

      TFullScreenLoader.openLoading(
          'Suppression en cours', CustomImage.animation);

      final produitRepository = ProduitRepository.Instance;
      final transactionRepo = HistoryTransactionRepository.instance;
      final transactionController = TransactionController.Instance;

      produitRepository.updateProduitQuantity(
          commande.productId, -commande.quantity);

      await transactionRepo.deleteCommande(commande.id);

      transactionController.fetchAllCommandes();

      //remove loader

      TFullScreenLoader.stopLoading();
      Get.back();

      TLoaders.successSnackBar(
          title: 'Congratulations!', message: 'Commande effacer avec succees');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      false;
      TFullScreenLoader.stopLoading();
    }
  }
}
