import 'package:easy_gestion/features/onBoarding/produit/controller/get_product_controller.dart';
import 'package:easy_gestion/features/onBoarding/produit/view/add_product.dart';
import 'package:easy_gestion/features/onBoarding/produit/view/edit_product_view.dart';
import 'package:easy_gestion/features/transaction/controller/transaction_controller.dart';
import 'package:easy_gestion/utils/constants/sizes.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Assurez-vous d'importer le contrôleur Produit

class HomeProduit extends StatefulWidget {
  const HomeProduit({super.key});

  @override
  State<HomeProduit> createState() => _HomeProduitState();
}

class _HomeProduitState extends State<HomeProduit> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer l'instance du contrôleur Produit
    final ProduitController produitController = ProduitController.Instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de Produit'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () => Get.to(() => AddProduct()),
              child: Text("Ajouter un produit"))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(CustomSize.defaultSpace),
        child: Obx(() {
          // Vérifier si la liste de produits est vide
          if (produitController.produits.isEmpty) {
            return Center(child: Text('Aucun produit disponible'));
          }

          // Afficher la liste des produits
          return ListView.separated(
            itemCount: produitController.produits.length,
            separatorBuilder: (_, int index) {
              return SizedBox(
                height: 5,
              );
            },
            itemBuilder: (_, index) {
              final produit = produitController.produits[index];

              return GestureDetector(
                onTap: () => Get.to(() => EditProductView(produit: produit)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor:
                        CustomHelperFunctions.getColor(produit.background),
                    child: Text(
                      produit.label[0].toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: Colors.white),
                    ), // Utiliser la première lettre du nom du produit
                  ),
                  title: Text(
                    produit.label,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    produit.category,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(color: CustomColors.futaColor),
                  ),
                  trailing: Text(
                    "${produit.quantity} pqt",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
