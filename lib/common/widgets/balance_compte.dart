import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BalanceCompte extends StatefulWidget {
  const BalanceCompte({
    super.key,
    this.balanceLabel = 'Total Balance',
    required this.totalBalance,
  });

  final String balanceLabel;
  final double totalBalance;

  @override
  _BalanceCompteState createState() => _BalanceCompteState();
}

class _BalanceCompteState extends State<BalanceCompte> {
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
        Text(
          widget.balanceLabel,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: CustomSize.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _isBalanceVisible
                  ? CustomHelperFunctions.currencyFormat
                      .format(widget.totalBalance)
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
