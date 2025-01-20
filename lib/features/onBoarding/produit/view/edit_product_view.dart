import 'package:easy_gestion/common/widgets/app_bar_custom.dart';
import 'package:easy_gestion/common/widgets/button_with_loading.dart';
import 'package:easy_gestion/features/onBoarding/produit/controller/edit_controller.dart';
import 'package:easy_gestion/model/produit_model.dart';
import 'package:easy_gestion/utils/constants/colors.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key, required this.produit});

  final ProduitModel produit;

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  late EditProductController controller;

  void initState() {
    super.initState();

    controller = Get.put(EditProductController());
    controller.init(widget.produit);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Modifier un produit',
        leading: true,
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmation'),
                    content: Text(
                        'Êtes-vous sûr de vouloir supprimer cet élément ?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Ferme le dialogue sans action
                        },
                        child: Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.DeleteProduit(widget.produit);
                          // Ajoutez ici la logique de suppression
                          Navigator.of(context).pop(); // Ferme le dialogue
                        },
                        child: Text('Supprimer'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Supprimer'),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(CustomSize.defaultSpace),
        child: Form(
          key: controller.productForm,
          child: ListView(
            children: [
              const SizedBox(
                height: CustomSize.spaceBtwSections,
              ),
              TextFormField(
                controller: controller.label,
                validator: (value) =>
                    CustomValidator.validatorEmptytext('Produit label', value),
                decoration: const InputDecoration(
                    hintText: 'Produit', prefixIcon: Icon(Iconsax.card)),
              ),
              const SizedBox(
                height: CustomSize.spaceBtwInputFields,
              ),
              DropdownButtonFormField<String>(
                  value: controller.category.text,
                  items: [
                    DropdownMenuItem(
                      child: Text('Jus'),
                      value: "jus",
                    ),
                    DropdownMenuItem(
                      child: Text('Eau'),
                      value: "eau",
                    )
                  ],
                  onChanged: (val) {
                    controller.category.text = val!;
                  }),
              const SizedBox(
                height: CustomSize.spaceBtwInputFields,
              ),
              TextFormField(
                controller: controller.quantity,
                validator: (value) =>
                    CustomValidator.validatorEmptytext('Quantite', value),
                decoration: const InputDecoration(
                    hintText: "Stock initial", prefixIcon: Icon(Iconsax.card)),
              ),
              SizedBox(
                height: CustomSize.spaceBtwItems,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Couleur d'arrière-plan"),
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            controller.selectedColor.value = Colors.red,
                        child: Obx(() => CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 20,
                              child:
                                  controller.selectedColor.value == Colors.red
                                      ? Icon(Icons.check, color: Colors.white)
                                      : null,
                            )),
                      ),
                      GestureDetector(
                        onTap: () =>
                            controller.selectedColor.value = Colors.blue,
                        child: Obx(() => CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 20,
                              child:
                                  controller.selectedColor.value == Colors.blue
                                      ? Icon(Icons.check, color: Colors.white)
                                      : null,
                            )),
                      ),
                      GestureDetector(
                        onTap: () =>
                            controller.selectedColor.value = Colors.green,
                        child: Obx(() => CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 20,
                              child:
                                  controller.selectedColor.value == Colors.green
                                      ? Icon(Icons.check, color: Colors.white)
                                      : null,
                            )),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(CustomSize.md),
        child: ButtonWithLoad(
          controller: () => controller..editProduit(widget.produit),
          label: 'Enregistrer',
        ),
      ),
    );
  }
}
