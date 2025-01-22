import 'package:easy_gestion/utils/constants/colors.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';

class BuildIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onPressed;
  final double borderCircular, heighText, iconSize;

  const BuildIconButton(
      {super.key,
      required this.icon,
      required this.label,
      this.borderCircular = 30,
      this.heighText = 80,
      this.iconSize = 30,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            //padding: ,
            decoration: BoxDecoration(
              color: dark ? Colors.grey[900] : Colors.grey[200],
              borderRadius: BorderRadius.circular(borderCircular),
            ),
            child: IconButton(
              padding: const EdgeInsets.all(12),
              icon: Icon(
                icon,
                size: iconSize,
                color: CustomColors.futaColor,
              ),
              onPressed: onPressed,
            ),
          ),
          SizedBox(
            width: heighText, // Set a fixed width to wrap text
            child: Text(
              label,
              textAlign: TextAlign.center, // Center align the text
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500), // Adjust font size if necessary
            ),
          ),
        ],
      ),
    );
  }
}
