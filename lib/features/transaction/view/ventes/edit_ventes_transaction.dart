import 'dart:convert';

import 'package:easy_gestion/common/widgets/button_with_loading.dart';
import 'package:easy_gestion/features/operation/controller/add_ventes_controller.dart';
import 'package:easy_gestion/features/transaction/controller/edit_transaction_controller.dart';
import 'package:easy_gestion/model/transaction_model.dart';
import 'package:easy_gestion/utils/constants/colors.dart';
import 'package:easy_gestion/utils/constants/sizes.dart';
import 'package:easy_gestion/utils/validators/validators.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class EditVentesTransaction extends StatefulWidget {
  const EditVentesTransaction(
      {super.key, required this.productTransactionModel});

  final ProductTransactionModel productTransactionModel;

  @override
  State<EditVentesTransaction> createState() => _EditVentesTransactionState();
}

class _EditVentesTransactionState extends State<EditVentesTransaction> {
  String intialDate = DateTime.now().toString();

  late EditTransactionController controller;

  void initState() {
    controller = Get.put(EditTransactionController());

    controller.initModel(widget.productTransactionModel);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier  transaction'),
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
                            controller.deleteTrasanction(
                                widget.productTransactionModel);
                            // Ajoutez ici la logique de suppression
                            // Navigator.of(context).pop(); // Ferme le dialogue
                          },
                          child: Text('Supprimer'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Effacer la transaction'))
        ],
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
                    value: widget.productTransactionModel.productId,
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
                    controller: () => controller
                        .editTransaction(widget.productTransactionModel),
                    label: 'Modifier',
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
