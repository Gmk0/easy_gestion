import 'package:easy_gestion/common/widgets/app_bar_custom.dart';
import 'package:easy_gestion/common/widgets/button_with_loading.dart';
import 'package:easy_gestion/features/onBoarding/produit/controller/new_product.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddProductController());
    return Scaffold(
      appBar: const AppBarCustom(
        title: 'Ajouter une carte',
        leading: true,
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
                    hintText: 'Produit', prefixIcon: Icon(Iconsax.box)),
              ),
              const SizedBox(
                height: CustomSize.spaceBtwInputFields,
              ),
              DropdownButtonFormField(
                  icon: Icon(Iconsax.box),
                  items: [
                    DropdownMenuItem(
                      child: Text('Jus'),
                      value: "jus",
                    ),
                    DropdownMenuItem(
                      child: Text('Eau'),
                      value: "eau",
                    ),
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
                    hintText: "Stock initial", prefixIcon: Icon(Icons.label)),
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
          controller: () => controller.addProduit(),
          label: 'Enregistrer',
        ),
      ),
    );
  }
}
