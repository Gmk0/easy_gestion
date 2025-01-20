import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';

class ListeTransac extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final String date;

  final String icon;
  const ListeTransac(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.icon,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: CustomHelperFunctions.getColor(icon),
        child: Text(
          title[0].toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: Colors.white),
        ), // Utiliser la première lettre du nom du produit
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${subtitle}",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: Colors.green),
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
      trailing: Text(
        CustomHelperFunctions.currencyFormat.format(price),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
