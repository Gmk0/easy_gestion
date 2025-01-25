import 'package:easy_gestion/common/widgets/loader_class.dart';
import 'package:easy_gestion/data/authentification.dart';
import 'package:easy_gestion/data/repositories/produit_repository.dart';
import 'package:easy_gestion/features/onBoarding/produit/controller/get_product_controller.dart';
import 'package:easy_gestion/model/produit_model.dart';
import 'package:easy_gestion/utils/constants/image_strings.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddProductController extends GetxController {
  static AddProductController get instance => Get.find();

  final label = TextEditingController();
  final quantity = TextEditingController();
  final background = TextEditingController();
  final category = TextEditingController();

  RxBool isLoading = false.obs;
  Rx<Color> selectedColor = Colors.red.obs;

  GlobalKey<FormState> productForm = GlobalKey<FormState>();

  Future<void> addProduit() async {
    try {
      isLoading.value = true;

      //final isConnected = await NetworkManager.instance.isConnected();

      if (!productForm.currentState!.validate()) {
        TLoaders.warningSnackBar(
          title: 'Remplir les champs',
          message: 'Veuillez remplir tous les champs.',
        );

        return;
      }

      final user = AuthenticationRepository.instance.authUser;
      var uuid = Uuid();

      //Register user in tehe firebase authentication

      final newUser = ProduitModel(
          id: uuid.v4(),
          label: label.text.trim(),
          category: category.text.trim(),
          quantity: double.parse(quantity.text),
          background:
              CustomHelperFunctions.functionGetColors(selectedColor.value));

      final produitRepository = ProduitRepository.Instance;
      await produitRepository.saveUserProduit(newUser, user!.uid);

      await ProduitController.Instance.fetchProduits().then((value) {
        clear();
      });

      //remove loader

      // TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Félicitations !',
        message: 'Le produit a été créé avec succès.',
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void clear() {
    label.text = "";
    category.text = "";
    quantity.text = "";
  }
}
