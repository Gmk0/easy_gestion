import 'package:easy_gestion/common/widgets/liste_transac.dart';
import 'package:easy_gestion/data/data.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListVentesSkeleton extends StatelessWidget {
  const ListVentesSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView(
        shrinkWrap: true,
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
}
