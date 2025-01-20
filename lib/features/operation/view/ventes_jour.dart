import 'dart:convert';

import 'package:easy_gestion/common/widgets/button_with_loading.dart';
import 'package:easy_gestion/features/operation/controller/add_ventes_controller.dart';
import 'package:easy_gestion/utils/constants/colors.dart';
import 'package:easy_gestion/utils/constants/sizes.dart';
import 'package:easy_gestion/utils/validators/validators.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class VentesJour extends StatefulWidget {
  const VentesJour({super.key});

  @override
  State<VentesJour> createState() => _VentesJourState();
}

class _VentesJourState extends State<VentesJour> {
  String intialDate = DateTime.now().toString();

  late AddVentesController controller;

  void initState() {
    controller = Get.put(AddVentesController());
    controller.priceVentes.addListener(calculateTotal);
    controller.quantity.addListener(calculateTotal);

    super.initState();
  }

  void calculateTotal() {
    double prix = double.tryParse(controller.priceVentes.text) ?? 0.0;
    int quantite = int.tryParse(controller.quantity.text) ?? 0;
    double total = prix * quantite;
    controller.totalVentes.text =
        total.toStringAsFixed(2); // Format à deux décimales
  }

  Future<void> _pickDateTime(BuildContext context) async {
    // Sélection de la date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Sélection de l'heure

// Formater la date pour afficher uniquement la date sans l'heure

      controller.dateTime.value = pickedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddVentesController());
    return Scaffold(
      appBar: AppBar(
        title: Text('ventes du jour'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CustomSize.defaultSpace),
          child: Form(
            key: controller.ventesForm,
            child: Column(
              spacing: 16,
              children: [
                Obx(() {
                  return DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: "Produit",
                      hintStyle: TextStyle(fontSize: 18),
                    ),
                    style: Theme.of(context).textTheme.titleMedium,
                    items: controller.produits
                        .map<DropdownMenuItem<String>>((produit) {
                      return DropdownMenuItem<String>(
                        child: Text(produit.label
                            .toUpperCase()), // Affiche le nom du produit
                        value: produit
                            .id, // Utilise le nom du produit comme valeur
                      );
                    }).toList(),
                    onChanged: (val) {
                      controller.produitId.text = val!;
                      // Action à effectuer lorsque la valeur change
                    },
                  );
                }),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(onPressed: () async {
                    _pickDateTime(context);
                  }, child: Obx(() {
                    return Text(
                      DateFormat('dd-MM-yyyy')
                          .format(controller.dateTime.value),
                      textAlign: TextAlign.start,
                    );
                  })),
                ),
                TextFormField(
                  validator: (value) => CustomValidator.validatorEmptytext(
                      'Prix de ventes', value),
                  controller: controller.priceVentes,

                  decoration: InputDecoration(
                    hintText: 'Prix de ventes',
                    hintStyle: TextStyle(
                        fontSize: 18), // Agrandir la taille du texte du hint
                  ),
                  style: TextStyle(
                      fontSize: 20), // Agrandir la taille du texte entré
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value) =>
                      CustomValidator.validatorEmptytext('Quantite', value),
                  controller: controller.quantity,
                  decoration: InputDecoration(
                    hintText: 'Quantité',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value) =>
                      CustomValidator.validatorEmptytext('Total', value),
                  controller: controller.totalVentes,
                  decoration: InputDecoration(
                    hintText: 'Total',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  style: TextStyle(fontSize: 20),
                  readOnly: true, // Le champ Total est en lecture seule
                ),
                SizedBox(
                  width: double.infinity,
                  child: ButtonWithLoad(
                    controller: () => controller.addTransaction(),
                    label: 'Enregistrer',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
