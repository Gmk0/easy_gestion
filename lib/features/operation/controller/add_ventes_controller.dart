import 'package:easy_gestion/common/widgets/loader_class.dart';

import 'package:easy_gestion/data/repositories/hitstory_transaction_repository.dart';
import 'package:easy_gestion/data/repositories/produit_repository.dart';
import 'package:easy_gestion/features/onBoarding/produit/controller/get_product_controller.dart';
import 'package:easy_gestion/features/onBoarding/view/home/controller/home_controller.dart';
import 'package:easy_gestion/features/transaction/controller/transaction_controller.dart';
import 'package:easy_gestion/model/produit_model.dart';

import 'package:easy_gestion/model/transaction_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddVentesController extends GetxController {
  final produitId = TextEditingController();
  final quantity = TextEditingController();
  final priceVentes = TextEditingController();

  var dateTime = DateTime.now().obs;

  final totalVentes = TextEditingController();

  RxBool isLoading = false.obs;

  GlobalKey<FormState> ventesForm = GlobalKey<FormState>();

  RxList<ProduitModel> produits =
      <ProduitModel>[].obs; // Liste de produits de type ProduitModel

  @override
  void onInit() {
    super.onInit();
    fetchProduits();
  }

  void clear() {
    totalVentes.text = "";
    quantity.text = "";
    priceVentes.text = "";
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

  Future<void> addTransaction() async {
    try {
      isLoading.value = true;

      //final isConnected = await NetworkManager.instance.isConnected();

      if (!ventesForm.currentState!.validate()) {
        TLoaders.warningSnackBar(
            title: 'veuillez remplier tout les elements',
            message: 'In order to create acount');
        return;
      }

      //Register user in tehe firebase authentication
      var uuid = Uuid();

      final transaction = ProductTransactionModel(
        id: uuid.v4(),
        productId: produitId.text,
        date: dateTime.value,
        quantity: double.parse(quantity.text),
        totalAmount: double.parse(totalVentes.text),
      );

      final produitRepository = ProduitRepository.Instance;

      final transactionRepo = HistoryTransactionRepository.instance;
      final produitController = ProduitController.Instance;

      final homeController = HomeController.instance;

      produitRepository.updateProduitQuantity(
          produitId.text, -double.parse(quantity.text));

      await transactionRepo.addTransaction(transaction);

      await produitController.fetchProduits();
      await homeController.fetchLastTransaction();

      if (Get.isRegistered<TransactionController>()) {
        final transactionController = TransactionController.Instance;
        transactionController.fetchAllVentes();

        // Le Controller est déjà enregistré
        print("Le Controller est déjà créé.");
      }

      //remove loader

      // TFullScreenLoader.stopLoading();
      clear();

      TLoaders.successSnackBar(
          title: 'Congratulations!',
          message: 'Transaction ajouter avec succees');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
