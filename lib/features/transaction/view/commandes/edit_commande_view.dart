import 'package:easy_gestion/common/widgets/button_with_loading.dart';
import 'package:easy_gestion/features/operation/controller/reaprovisionnement_controller.dart';
import 'package:easy_gestion/model/reaprovisionement_model.dart';
import 'package:easy_gestion/utils/constants/sizes.dart';
import 'package:easy_gestion/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReapprovisionnementEdit extends StatefulWidget {
  const ReapprovisionnementEdit({super.key, required this.commande});

  final CommanndeTransactionModel commande;

  @override
  State<ReapprovisionnementEdit> createState() =>
      _ReapprovisionnementEditState();
}

class _ReapprovisionnementEditState extends State<ReapprovisionnementEdit> {
  String intialDate = DateTime.now().toString();

  late CommandesController controller;

  void initState() {
    super.initState();

    controller = Get.put(CommandesController());
    controller.initController(widget.commande);
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

      controller.dateTime.value = pickedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Commandes'), actions: [
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
                          controller.deleteCommandes(widget.commande);
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
            child: Text('Effacer la commande'))
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CustomSize.defaultSpace),
          child: Form(
            key: controller.commandesForm,
            child: Column(
              spacing: 16,
              children: [
                Obx(() {
                  return DropdownButtonFormField(
                    value: widget.commande.productId,
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
                      // Action à effectuer lorsque la valeur change
                    },
                  );
                }),
                TextFormField(
                  validator: (value) => CustomValidator.validatorEmptytext(
                      'Prix de ventes', value),
                  controller: controller.commandeesPrice,

                  decoration: InputDecoration(
                    hintText: 'Prix de commandes',
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
                SizedBox(
                  width: double.infinity,
                  child: ButtonWithLoad(
                    controller: () => controller.editCommandes(widget.commande),
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
