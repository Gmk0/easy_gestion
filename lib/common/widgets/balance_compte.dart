import 'dart:async';

import 'package:easy_gestion/data/repositories/hitstory_transaction_repository.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BalanceCompte extends StatefulWidget {
  const BalanceCompte({
    super.key,
  });

  @override
  _BalanceCompteState createState() => _BalanceCompteState();
}

class _BalanceCompteState extends State<BalanceCompte> {
  // StreamController pour combiner les flux
  final StreamController<Map<String, double>> _controller =
      StreamController<Map<String, double>>();

  // Initialisation des abonnements
  StreamSubscription? productSubscription;
  StreamSubscription? commandesSubscription;
  StreamSubscription? depensesSubscription;
  String _selectedCategory = 'Ventes'; // Catégorie par défaut

  // Variables pour stocker les totaux
  double productTotal = 0.0;
  double commandesTotal = 0.0;
  double depensesTotal = 0.0;
  bool _isBalanceVisible = true;

  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    // Écoute des flux
    final productTransactionsStream =
        HistoryTransactionRepository.instance.getTotalAmountStream();

    final commandesStream =
        HistoryTransactionRepository.instance.getTotalAmountCommandeStream();

    final depensesStream =
        HistoryTransactionRepository.instance.getTotalAmountDepensesStream();

    // Abonnir aux flux
    productSubscription = productTransactionsStream.listen((total) {
      productTotal = total;
      _updateController();
    });

    commandesSubscription = commandesStream.listen((total) {
      commandesTotal = total;
      _updateController();
    });

    depensesSubscription = depensesStream.listen((total) {
      depensesTotal = total;
      _updateController();
    });
  }

  // Méthode pour mettre à jour le StreamController
  void _updateController() {
    _controller.sink.add({
      "Ventes": productTotal,
      "Commandes": commandesTotal,
      "Dépenses": depensesTotal,
    });
  }

  @override
  void dispose() {
    // Annulez les abonnements et fermez le StreamController
    productSubscription?.cancel();
    commandesSubscription?.cancel();
    depensesSubscription?.cancel();
    _controller.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, double>>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return BalanceCompteShimer();
        }

        if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        }

        final totals =
            snapshot.data ?? {"Ventes": 0, "Commandes": 0, "Dépenses": 0};
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sélectionnez une catégorie :',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: totals.keys.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: CustomSize.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isBalanceVisible
                      ? CustomHelperFunctions.currencyFormat
                          .format(totals[_selectedCategory] ?? 0.0)
                      : 'CDF ****', // Masquer la balance
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                  onPressed: _toggleBalanceVisibility,
                  icon: Icon(
                    _isBalanceVisible ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class BalanceComteTransac extends StatefulWidget {
  const BalanceComteTransac({super.key, required this.totalBalance});

  final double totalBalance;

  @override
  State<BalanceComteTransac> createState() => _BalanceComteTransacState();
}

class _BalanceComteTransacState extends State<BalanceComteTransac> {
  bool _isBalanceVisible = true;

  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: CustomSize.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _isBalanceVisible
                  ? CustomHelperFunctions.currencyFormat
                      .format(widget.totalBalance)
                  : ' *********** CDF', // Masquer la balance
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              onPressed: _toggleBalanceVisibility,
              icon: Icon(
                _isBalanceVisible ? Iconsax.eye_slash : Iconsax.eye,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BalanceCompteShimer extends StatelessWidget {
  const BalanceCompteShimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total ventes",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: CustomSize.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "10000000", // Masquer la balance
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.eye_slash,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
