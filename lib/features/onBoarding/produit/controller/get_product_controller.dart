import 'package:easy_gestion/data/repositories/produit_repository.dart';
import 'package:easy_gestion/model/produit_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
// Assurez-vous que vous avez importé votre repository

class ProduitController extends GetxController {
  static ProduitController get Instance => Get.find();

  RxList<ProduitModel> produits =
      <ProduitModel>[].obs; // Liste de produits de type ProduitModel

  @override
  void onInit() {
    super.onInit();
    fetchProduits();
  }

  Future<void> fetchProduits() async {
    try {
      final produitRepository = ProduitRepository.Instance;
      final fetchedProduits = await produitRepository.fetchProduitDetails();

      if (fetchedProduits != null) {
        produits.value =
            fetchedProduits; // Mettre à jour la liste avec les produits récupérés
      }
    } catch (e) {
      print('Erreur lors de la récupération des produits: $e');
    }
  }
}
