import 'package:easy_gestion/common/widgets/loader_class.dart';

import 'package:easy_gestion/data/repositories/hitstory_transaction_repository.dart';
import 'package:easy_gestion/data/repositories/produit_repository.dart';
import 'package:easy_gestion/features/onBoarding/produit/controller/get_product_controller.dart';
import 'package:easy_gestion/features/onBoarding/view/home/controller/home_controller.dart';
import 'package:easy_gestion/features/transaction/controller/transaction_controller.dart';
import 'package:easy_gestion/model/produit_model.dart';

import 'package:easy_gestion/model/transaction_model.dart';
import 'package:easy_gestion/utils/constants/image_strings.dart';
import 'package:easy_gestion/utils/popups/full_screen_loader.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EditTransactionController extends GetxController {
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

  void initModel(ProductTransactionModel produit) {
    totalVentes.text = produit.totalAmount.toString();
    quantity.text = produit.quantity.toString();
    priceVentes.text = (produit.totalAmount / produit.quantity).toString();
    produitId.text = produit.product.toString();
  }

  void clear() {
    totalVentes.text = "";
    quantity.text = "";
    priceVentes.text = "";
  }

  Future<void> fetchProduits() async {
    try {
      final produitRepository = ProduitRepository.Instance;
      final fetchedProduits = await produitRepository.fetchProduitDetails();

      produits.value =
          fetchedProduits; // Mettre à jour la liste avec les produits récupérés
    } catch (e) {
      print('Erreur lors de la récupération des produits: $e');
    }
  }

  Future<void> deleteTrasanction(ProductTransactionModel transaction) async {
    try {
      //final isConnected = await NetworkManager.instance.isConnected();

      TFullScreenLoader.openLoading(
          'Suppression en cours', CustomImage.animation);

      final produitRepository = ProduitRepository.Instance;
      final transactionRepo = HistoryTransactionRepository.instance;

      final transactionController = TransactionController.Instance;

      final homeController = HomeController.instance;
      produitRepository.updateProduitQuantity(
          transaction.productId, transaction.quantity);

      await transactionRepo.deleteTransaction(transaction.id);

      await homeController.fetchLastTransaction();
      await transactionController.fetchAllVentes();

      //remove loader

      TFullScreenLoader.stopLoading();
      Get.back();

      TLoaders.successSnackBar(
          title: 'Congratulations!',
          message: 'Transaction effacer avec succees');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      false;
      TFullScreenLoader.stopLoading();
    }
  }

  Future<void> editTransaction(ProductTransactionModel transaction) async {
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

      var data = {
        'quantity': double.parse(quantity.text),
        'totalAmount': double.parse(totalVentes.text),
      };

      final produitRepository = ProduitRepository.Instance;
      final transactionRepo = HistoryTransactionRepository.instance;
      final produitController = ProduitController.Instance;
      final transactionController = TransactionController.Instance;

      var qty = transaction.quantity - double.parse(quantity.text);

      final homeController = HomeController.instance;
      produitRepository.updateProduitQuantity(transaction.id, qty);

      await transactionRepo.updateTransaction(transaction.id, data);

      // await transactionRepo.getTotalAmount();
      await transactionRepo.fetchAllTransactions();
      await homeController.fetchLastTransaction();
      await homeController.getTotalBalance();
      await transactionController.fetchAllVentes();

      //remove loader

      // TFullScreenLoader.stopLoading();
      Get.back();

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
