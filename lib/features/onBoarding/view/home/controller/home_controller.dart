import 'package:easy_gestion/data/repositories/hitstory_transaction_repository.dart';
import 'package:easy_gestion/data/repositories/produit_repository.dart';
import 'package:easy_gestion/model/transaction_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  var totalVentes = 0.0.obs;

  RxList<ProductTransactionModel> lastTransaction =
      <ProductTransactionModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchAllData();
  }

  Future<void> fetchAllData() async {
    isLoading.value = true; // Début du chargement
    try {
      await Future.wait([fetchLastTransaction()]);
    } catch (e) {
      print('Erreur lors de la récupération des données: $e');
    } finally {
      isLoading.value = false; // Fin du chargement
    }
  }

  Stream<double>? getTotalBalance() {
    try {
      var historyRepository = HistoryTransactionRepository.instance;

      return historyRepository.getTotalAmountStream();
    } catch (e) {}
  }

  Future<void> fetchLastTransaction() async {
    try {
      final produitRepository = HistoryTransactionRepository.instance;
      final fetchedTransaction = await produitRepository.fetchAllTransactions();

      print("feth transaction   ${fetchedTransaction}");

      if (fetchedTransaction != null) {
        lastTransaction.value =
            fetchedTransaction; // Mettre à jour la liste avec les produits récupérés
      }
    } catch (e) {
      print('Erreur lors de la récupération des produits: $e');
    }
  }
}
