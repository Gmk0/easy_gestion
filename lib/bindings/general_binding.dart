import 'package:easy_gestion/bindings/network_manager.dart';
import 'package:easy_gestion/data/repositories/hitstory_transaction_repository.dart';
import 'package:easy_gestion/data/repositories/produit_repository.dart';
import 'package:easy_gestion/data/repositories/user_repository.dart';
import 'package:easy_gestion/features/onBoarding/produit/controller/get_product_controller.dart';
import 'package:easy_gestion/features/transaction/controller/transaction_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProduitRepository>(() => ProduitRepository());
    //Get.put(ProduitRepository());

    //Get.put(ProduitController());
    Get.lazyPut<ProduitController>(() => ProduitController());

    //Get.put(TransactionController());
  }
}
