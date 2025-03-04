import 'package:easy_gestion/common/widgets/loader_class.dart';
import 'package:easy_gestion/utils/constants/colors.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';

class ButtonWithLoad extends StatelessWidget {
  const ButtonWithLoad({
    super.key,
    required this.controller,
    required this.label,
  });

  final Function controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return EasyButton(
      idleStateWidget: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      loadingStateWidget: const CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white,
        ),
      ),
      useWidthAnimation: true,
      useEqualLoadingStateWidgetDimension: true,
      width: 150.0,
      height: 50.0,
      borderRadius: 6.0,
      contentGap: 6.0,
      buttonColor: CustomColors.futaColor,
      onPressed: () async {
        if (await ConnectivityWrapper.instance.isConnected) {
          await controller();
        } else {
          TLoaders.errorSnackBar(
              title: 'Oh snap',
              message: "vous n'etes pas connecter a internet");
        }
      },
    );
  }
}
