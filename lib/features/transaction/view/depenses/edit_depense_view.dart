import 'package:easy_gestion/common/widgets/button_with_loading.dart';
import 'package:easy_gestion/features/operation/controller/add_depense.dart';
import 'package:easy_gestion/model/depense_model.dart';
import 'package:easy_gestion/utils/constants/sizes.dart';
import 'package:easy_gestion/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DepensesEdit extends StatefulWidget {
  const DepensesEdit({super.key, required this.depense});
  final DepenseModel depense;

  @override
  State<DepensesEdit> createState() => _DepensesEditState();
}

class _DepensesEditState extends State<DepensesEdit> {
  String intialDate = DateTime.now().toString();

  late AddDepensesController controller;

  void initState() {
    super.initState();

    controller = Get.put(AddDepensesController());
    controller.initModel(widget.depense);
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
      appBar: AppBar(
        title: Text('DepensesEdit'),
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
                            controller.deleteDepense(widget.depense);
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
            key: controller.depenseForm,
            child: Column(
              spacing: 16,
              children: [
                TextFormField(
                  validator: (value) => CustomValidator.validatorEmptytext(
                      'titre de la depense', value),
                  controller: controller.titre,
                  decoration: InputDecoration(hintText: 'titre de la depense'),
                ),
                TextFormField(
                  controller: controller.montant,
                  validator: (value) =>
                      CustomValidator.validatorEmptytext('Montant', value),
                  decoration: InputDecoration(
                    hintText: 'Montant',
                    hintStyle: TextStyle(
                        fontSize: 18), // Agrandir la taille du texte du hint
                  ),
                  style: TextStyle(
                      fontSize: 20), // Agrandir la taille du texte entré
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: controller.description,
                  validator: (value) =>
                      CustomValidator.validatorEmptytext('Description', value),
                  maxLines: null,
                  minLines: 4,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                SizedBox(
                    width: double.infinity,
                    child: ButtonWithLoad(
                        controller: () =>
                            controller.editDepenses(widget.depense),
                        label: 'Modifier'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
