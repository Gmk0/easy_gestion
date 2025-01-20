import 'package:easy_gestion/data/repositories/hitstory_transaction_repository.dart';
import 'package:easy_gestion/data/repositories/produit_repository.dart';
import 'package:easy_gestion/model/depense_model.dart';
import 'package:easy_gestion/model/produit_model.dart';
import 'package:easy_gestion/model/reaprovisionement_model.dart';
import 'package:easy_gestion/model/transaction_model.dart';
import 'package:get/get.dart';

// Assurez-vous que vous avez importé votre repository

class TransactionController extends GetxController {
  static TransactionController get Instance => Get.find();

  RxList<ProductTransactionModel> ventes = <ProductTransactionModel>[].obs;

  RxList<ProductTransactionModel> originalVentes =
      <ProductTransactionModel>[].obs;

  RxList<CommanndeTransactionModel> commandeList =
      <CommanndeTransactionModel>[].obs;
  RxList<DepenseModel> depensesList = <DepenseModel>[].obs;

  RxList<String> productOptions = ['Tous les produits'].obs;

  var totalVentes = 0.0.obs;
  var totalCommandes = 0.0.obs;
  var totalDepenses = 0.0.obs;

  var totalBalanceFilter = 0.0.obs;
  var totalBalanceFilterDepenses = 0.0.obs;
  var totalBalanceFilterCommandes = 0.0.obs;

  RxBool isLoading = false.obs; // Indicateur de chargement global

  @override
  void onInit() {
    super.onInit();
    fetchAllData(); // Appel à une fonction pour récupérer toutes les données
  }

  Future<void> fetchAllData() async {
    isLoading.value = true; // Début du chargement
    try {
      await Future.wait([
        fetchAllVentes(),
        fetchAllDepenses(),
        fetchAllCommandes(),
      ]);
    } catch (e) {
      print('Erreur lors de la récupération des données: $e');
    } finally {
      isLoading.value = false; // Fin du chargement
    }
  }

  Future<void> fetchAllVentes() async {
    try {
      final historyRepository = HistoryTransactionRepository.instance;
      final fetchedVentes = await historyRepository.fetchAllTransactions();
      if (fetchedVentes != null) {
        ventes.value = fetchedVentes;
        originalVentes.value = fetchedVentes;

        _initializeProductOptions();
      }
    } catch (e) {
      print('Erreur lors de la récupération des ventes: $e');
    }
  }

  Future<void> fetchAllCommandes() async {
    try {
      final historyRepository = HistoryTransactionRepository.instance;
      final fetchedCommandes = await historyRepository.fetchAllCommmandes();
      if (fetchedCommandes != null) {
        commandeList.value = fetchedCommandes;
      }
    } catch (e) {
      print('Erreur lors de la récupération des commandes: $e');
    }
  }

  Future<void> fetchAllDepenses() async {
    try {
      final historyRepository = HistoryTransactionRepository.instance;
      final fetchedDepenses = await historyRepository.fetchAllDepenses();
      if (fetchedDepenses != null) {
        depensesList.value = fetchedDepenses;
      }
    } catch (e) {
      print('Erreur lors de la récupération des dépenses: $e');
    }
  }

  void filterVentesByDate(DateTime startDate, DateTime endDate) {
    final filteredVentes = ventes.where((vente) {
      final venteDate = vente.date;
      return venteDate.isAfter(startDate) && venteDate.isBefore(endDate);
    }).toList();
    ventes.value = filteredVentes;

    // Calculer la somme du totalAmount dans les ventes filtrées
    totalBalanceFilter.value =
        filteredVentes.fold(0.0, (sum, vente) => sum + vente.totalAmount);

    // Afficher ou utiliser la somme selon le besoin
    // print('Somme totale: $totalAmountSum');
  }

  void filterDepensesByDate(DateTime startDate, DateTime endDate) {
    final filteredDepenses = depensesList.where((depense) {
      final depenseDate = depense.date;
      return depenseDate.isAfter(startDate) && depenseDate.isBefore(endDate);
    }).toList();
    depensesList.value = filteredDepenses;

    // Calculer la somme du totalAmount dans les ventes filtrées
    totalBalanceFilterDepenses.value =
        filteredDepenses.fold(0.0, (sum, vente) => sum + vente.totalAmount);

    // Afficher ou utiliser la somme selon le besoin
    // print('Somme totale: $totalAmountSum');
  }

  void filterCommandesByDate(DateTime startDate, DateTime endDate) {
    final filteredCommandes = commandeList.where((vente) {
      final venteDate = vente.date;
      return venteDate.isAfter(startDate) && venteDate.isBefore(endDate);
    }).toList();
    commandeList.value = filteredCommandes;

    // Calculer la somme du totalAmount dans les ventes filtrées
    totalBalanceFilterCommandes.value = filteredCommandes.fold(
        0.0, (sum, commande) => sum + commande.totalAmount);

    // Afficher ou utiliser la somme selon le besoin
    // print('Somme totale: $totalAmountSum');
  }

  // Initialise les options de produits disponibles
  void _initializeProductOptions() {
    productOptions.value = ['Tous les produits'];
    final productLabels =
        ventes.map((vente) => vente.product!.label).toSet().toList();

    productOptions.addAll(productLabels);
  }
}
