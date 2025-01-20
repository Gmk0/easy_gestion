import 'package:easy_gestion/common/widgets/tab_custom.dart';
import 'package:easy_gestion/features/transaction/controller/transaction_controller.dart';
import 'package:easy_gestion/features/transaction/view/commandes/commandes_transaction.dart';

import 'package:easy_gestion/features/transaction/view/depenses/depensesList.dart';
import 'package:easy_gestion/features/transaction/view/ventes/ventes_transac.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListeTransaction extends StatefulWidget {
  const ListeTransaction({super.key});

  @override
  State<ListeTransaction> createState() => _ListeTransactionState();
}

class _ListeTransactionState extends State<ListeTransaction> {
  final transactionController = TransactionController.Instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Liste Transaction'),
          bottom: const TabBarCustom(
            tabs: [
              Tab(text: 'Ventes'),
              Tab(text: 'Commandes'),
              Tab(text: 'Depenses'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            VentesTransac(
              venteController: transactionController,
            ),
            CommandesTransaction(
              commandeController: transactionController,
            ),
            DepesenseTransaction(
              transactionController: transactionController,
            ),
          ],
        ),
      ),
    );
  }
}
