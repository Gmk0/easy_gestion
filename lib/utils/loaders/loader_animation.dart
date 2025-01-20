import 'package:easy_gestion/utils/constants/colors.dart';
import 'package:easy_gestion/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../export.dart';

class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      this.actiontext,
      this.showAction = false,
      this.onActionPressed});

  final String text, animation;
  final String? actiontext;
  final bool showAction;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(animation,
              width: MediaQuery.of(context).size.width * 0.4),
          const SizedBox(height: CustomSize.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CustomSize.defaultSpace),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                      onPressed: onActionPressed,
                      child: Text(
                        actiontext!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: CustomColors.light),
                      )),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
