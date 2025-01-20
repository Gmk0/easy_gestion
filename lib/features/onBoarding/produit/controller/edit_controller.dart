import 'package:easy_gestion/common/widgets/loader_class.dart';
import 'package:easy_gestion/data/authentification.dart';
import 'package:easy_gestion/data/repositories/produit_repository.dart';
import 'package:easy_gestion/features/onBoarding/produit/controller/get_product_controller.dart';
import 'package:easy_gestion/model/produit_model.dart';
import 'package:easy_gestion/utils/constants/image_strings.dart';
import 'package:easy_gestion/utils/helpers/helper_function.dart';
import 'package:easy_gestion/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  final label = TextEditingController();
  final quantity = TextEditingController();
  final background = TextEditingController();
  final category = TextEditingController();

  void init(ProduitModel produit) {
    label.text = produit.label;
    quantity.text = produit.quantity.toString();
    //  background.text = produit.background;
    category.text = produit.category;
  }

  RxBool isLoading = false.obs;
  Rx<Color> selectedColor = Colors.red.obs;

  GlobalKey<FormState> productForm = GlobalKey<FormState>();

  Future<void> editProduit(ProduitModel produit) async {
    try {
      isLoading.value = true;
      TFullScreenLoader.openLoading(
          'we are proccessiong your informatio', CustomImage.animation);

      //final isConnected = await NetworkManager.instance.isConnected();

      if (!productForm.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        isLoading.value = false;
        TLoaders.warningSnackBar(
            title: 'Accept privacy policy',
            message: 'In order to create acount');
        return;
      }

      //Register user in tehe firebase authentication

      final produit = ProduitModel(
          id: DateTime.now().toIso8601String(),
          label: label.text.trim(),
          category: category.text.trim(),
          quantity: double.parse(quantity.text),
          background:
              CustomHelperFunctions.functionGetColors(selectedColor.value));

      final produitRepository = ProduitRepository.Instance;
      await produitRepository.updateProduit(produit.id, produit.toMap());

      await ProduitController.Instance.fetchProduits();

      //remove loader

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Congratulations!', message: 'Le produit a ete bien modifier');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  Future<void> DeleteProduit(ProduitModel produit) async {
    try {
      TFullScreenLoader.openLoading(
          'Suppression en cours', CustomImage.animation);

      final produitRepository = ProduitRepository.Instance;
      await produitRepository.deleteProduit(produit.id);

      await ProduitController.Instance.fetchProduits();

      // Get.back();
      //remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations!', message: 'Le produit a ete bien modifier');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
