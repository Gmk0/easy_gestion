import 'package:easy_gestion/utils/constants/colors.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    required this.width, // Largeur du Shimmer
    required this.height, // Hauteur du Shimmer
    this.radius = 15, // Rayon des bords
    this.color, // Couleur de fond
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(
        context); // Vérifie si le mode sombre est activé
    return Shimmer.fromColors(
      baseColor: dark
          ? Colors.grey[850]!
          : Colors.grey[300]!, // Couleur de base du Shimmer
      highlightColor: dark
          ? Colors.grey[700]!
          : Colors.grey[100]!, // Couleur de surbrillance du Shimmer
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ??
              (dark
                  ? CustomColors.darkerGrey
                  : CustomColors.white), // Couleur du conteneur
          borderRadius:
              BorderRadius.circular(radius), // Rayon des bords du conteneur
        ),
      ),
    );
  }
}
