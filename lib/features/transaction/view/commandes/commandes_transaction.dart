import 'package:easy_gestion/common/skeleton/container_skeleton.dart';
import 'package:easy_gestion/common/widgets/balance_compte.dart';
import 'package:easy_gestion/common/widgets/build_icon_button.dart';
import 'package:easy_gestion/common/widgets/liste_transac.dart';
import 'package:easy_gestion/common/widgets/printing.dart';
import 'package:easy_gestion/data/data.dart';
import 'package:easy_gestion/data/repositories/hitstory_transaction_repository.dart';

import 'package:easy_gestion/features/operation/view/depenses.dart';
import 'package:easy_gestion/features/transaction/controller/transaction_controller.dart';
import 'package:easy_gestion/features/transaction/view/commandes/edit_commande_view.dart';
import 'package:easy_gestion/model/reaprovisionement_model.dart';
import 'package:easy_gestion/model/transaction_model.dart';
import 'package:easy_gestion/utils/constants/sizes.dart';
import 'package:easy_gestion/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CommandesTransaction extends StatefulWidget {
  const CommandesTransaction({super.key, required this.commandeController});
  final TransactionController commandeController;

  @override
  State<CommandesTransaction> createState() => _CommandesTransactionState();
}

class _CommandesTransactionState extends State<CommandesTransaction> {
  DateTimeRange? _selectedDateRange;
  bool _isFilterActive = false;

  String _selectedProduct =
      'Tous les produits'; // État pour la sélection actuelle
  List<String> _productOptions = [
    'Tous les produits'
  ]; // Liste des options de produits

  @override
  void initState() {
    super.initState();
  }

  /*
  void _onProductSelected(String? newValue) {
    if (newValue == null) return;

    setState(() {
      _selectedProduct = newValue;
      if (_selectedProduct == 'Tous les produits') {
        widget.commandeController.ventes.value =
            widget.commandeController.originalVentes;
      } else {
        widget.commandeController.ventes.value =
            widget.commandeController.originalVentes.where((vente) {
          return vente.product!.label == _selectedProduct;
        }).toList();
      }
    });
  } */

  void _resetFilters() {
    setState(() {
      _selectedDateRange = null;
      _isFilterActive = false;
    });
    widget.commandeController
        .fetchAllVentes(); // Recharge les ventes sans filtre
  }

  void printPdf(List<CommanndeTransactionModel> commandes) async {
    final pdfData = await generatePdfCommandes(commandes);
    await Printing.layoutPdf(
      onLayout: (format) async => pdfData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            if (widget.commandeController.isLoading.value) {
              return ContainerTitreSkeleton();
            }
            return Container(
              margin: EdgeInsets.all(CustomSize.md),
              padding: EdgeInsets.all(CustomSize.md),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(25),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOTAL COMMANDES",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: CustomSize.sm),
                  StreamBuilder<double>(
                    stream: HistoryTransactionRepository.instance
                        .getTotalAmountCommandeStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return BalanceCompteShimer(); // Ou n'importe quel widget de chargement
                      }
                      if (snapshot.hasError) {
                        return Text('Erreur : ${snapshot.error}');
                      }
                      if (!snapshot.hasData) {
                        return Text('Aucune donnée disponible');
                      }

                      return BalanceComteTransac(
                        totalBalance: snapshot.data!,
                      );
                    },
                  ),
                  Divider(),
                  Row(
                    children: [
                      BuildIconButton(
                        icon: Iconsax.filter,
                        iconSize: 24,
                        label: _isFilterActive
                            ? 'Filtre actif'
                            : 'Filtres par date',
                        onPressed: () async {
                          final DateTimeRange? picked =
                              await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );

                          if (picked != null) {
                            setState(() {
                              _selectedDateRange = picked;
                              _isFilterActive = true;
                            });
                            widget.commandeController.filterCommandesByDate(
                                picked.start, picked.end);
                          }
                        },
                      ),
                      BuildIconButton(
                          icon: Iconsax.printer,
                          iconSize: 24,
                          label: 'Imprimer',
                          onPressed: () {
                            printPdf(widget.commandeController.commandeList);
                          }),
                    ],
                  ),
                  AnimatedOpacity(
                    opacity: _isFilterActive ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: _isFilterActive
                        ? Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: _resetFilters,
                              child: Column(
                                spacing: 12,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withAlpha(50),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${DateFormat('dd MMM').format(_selectedDateRange!.start)} - ${DateFormat('dd MMM').format(_selectedDateRange!.end)}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Réinitialiser',
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    CustomHelperFunctions.currencyFormat.format(
                                        widget.commandeController
                                            .totalBalanceFilterCommandes.value),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            );
          }),
          /*
          Obx(() => Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(CustomSize.md),
                  child: DropdownButton<String>(
                    value: _selectedProduct,
                    items: widget.commandeController.productOptions.map((product) {
                      return DropdownMenuItem(
                        value: product,
                        child: Text(product),
                      );
                    }).toList(),
                    onChanged: _onProductSelected,
                  ),
                ),
              )), */
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(CustomSize.defaultSpace),
              child: Obx(() {
                if (widget.commandeController.isLoading.value) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView(
                      children: elements
                          .map(
                            (item) => ListeTransac(
                              icon: "string",
                              title: item['title'],
                              subtitle: item['subtitle'],
                              date: '21/03/2023',
                              price: 2000.0,
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
                if (widget.commandeController.commandeList.isEmpty) {
                  return Center(child: Text('Aucun produit disponible'));
                }

                return ListView.separated(
                  itemCount: widget.commandeController.commandeList.length,
                  separatorBuilder: (_, int index) => SizedBox(height: 5),
                  itemBuilder: (_, index) {
                    final commande =
                        widget.commandeController.commandeList[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => ReapprovisionnementEdit(
                            commande: commande,
                          )),
                      child: ListeTransac(
                        icon: commande.product!.background,
                        title: commande.product!.label,
                        date: DateFormat('dd-MM-yyyy').format(commande.date),
                        subtitle: "ventes",
                        price: commande.totalAmount,
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
