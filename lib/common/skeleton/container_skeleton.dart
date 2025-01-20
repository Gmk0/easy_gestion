import 'package:easy_gestion/common/widgets/balance_compte.dart';
import 'package:easy_gestion/common/widgets/build_icon_button.dart';

import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ContainerTitreSkeleton extends StatelessWidget {
  const ContainerTitreSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
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
              "TOTAL VENTES",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: CustomSize.sm),
            BalanceComteTransac(
              totalBalance: 300000,
            ),
            Divider(),
            Row(
              children: [
                BuildIconButton(
                  icon: Iconsax.filter,
                  iconSize: 24,
                  label: 'Filtres',
                  onPressed: () async {},
                ),
                BuildIconButton(
                    icon: Iconsax.printer,
                    iconSize: 24,
                    label: 'Imprimer',
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
