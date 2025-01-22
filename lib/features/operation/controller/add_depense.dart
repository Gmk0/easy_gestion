import 'package:easy_gestion/common/widgets/loader_class.dart';

import 'package:easy_gestion/data/repositories/hitstory_transaction_repository.dart';
import 'package:easy_gestion/data/repositories/produit_repository.dart';
import 'package:easy_gestion/features/onBoarding/produit/controller/get_product_controller.dart';
import 'package:easy_gestion/features/onBoarding/view/home/controller/home_controller.dart';
import 'package:easy_gestion/features/transaction/controller/transaction_controller.dart';
import 'package:easy_gestion/model/depense_model.dart';
import 'package:easy_gestion/model/produit_model.dart';

import 'package:easy_gestion/model/transaction_model.dart';
import 'package:easy_gestion/utils/constants/image_strings.dart';
import 'package:easy_gestion/utils/popups/full_screen_loader.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddDepensesController extends GetxController {
  final titre = TextEditingController();
  final montant = TextEditingController();
  final description = TextEditingController();

  var dateTime = DateTime.now().obs;

  RxBool isLoading = false.obs;

  GlobalKey<FormState> depenseForm = GlobalKey<FormState>();

  GlobalKey<FormState> depenseFormEdit = GlobalKey<FormState>();
// Liste de produits de type ProduitModel

  @override
  void onInit() {
    super.onInit();
  }

  void initModel(DepenseModel model) {
    montant.text = model.totalAmount.toString();
    titre.text = model.title.toString();
    description.text = model.description.toString();
  }

  void clear() {
    montant.text = "";
    titre.text = "";
    description.text = "";
  }

  Future<void> addDepenses() async {
    try {
      //final isConnected = await NetworkManager.instance.isConnected();

      if (!depenseForm.currentState!.validate()) {
        TLoaders.warningSnackBar(
            title: 'veuillez remplier tout les elements',
            message: 'In order to create acount');
        return;
      }

      //Register user in tehe firebase authentication
      var uuid = Uuid();

      final transaction = DepenseModel(
        id: uuid.v4(),
        title: titre.text,
        date: dateTime.value,
        description: description.text,
        totalAmount: double.parse(montant.text),
      );

      final transactionRepo = HistoryTransactionRepository.instance;

      await transactionRepo.addDepenses(transaction);

      // await transactionRepo.getTotalAmount();

      if (Get.isRegistered<TransactionController>()) {
        final transactionController = TransactionController.Instance;
        transactionController.fetchAllDepenses();

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

  Future<void> editDepenses(DepenseModel depense) async {
    try {
      //final isConnected = await NetworkManager.instance.isConnected();

      if (!depenseFormEdit.currentState!.validate()) {
        TLoaders.warningSnackBar(
            title: 'veuillez remplier tout les elements',
            message: 'In order to create acount');
        return;
      }

      var data = {
        'description': description.text,
        'title': titre.text,
        'totalAmount': double.parse(montant.text),
      };

      final transactionRepo = HistoryTransactionRepository.instance;

      await transactionRepo.updateDepense(depense.id, data);

      await transactionRepo.fetchAllDepenses();

      clear();

      // await transactionRepo.getTotalAmount();

      Get.back();
      //remove loader

      // TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Congratulations!', message: 'Depenses modifier avec succees');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDepense(DepenseModel depense) async {
    try {
      //final isConnected = await NetworkManager.instance.isConnected();

      TFullScreenLoader.openLoading(
          'Suppression en cours', CustomImage.animation);

      final transactionRepo = HistoryTransactionRepository.instance;

      final transactionController = TransactionController.Instance;

      await transactionRepo.deleteDepense(depense.id);

      await transactionController.fetchAllDepenses();

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
