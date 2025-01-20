import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/loaders/loader_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TFullScreenLoader {
  static void openLoading(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (
          _,
        ) =>
            PopScope(
                child: Container(
              width: double.infinity,
              height: double.infinity,
              color: CustomHelperFunctions.isDarkMode(Get.context!)
                  ? CustomColors.dark
                  : CustomColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  TAnimationLoaderWidget(text: text, animation: animation),
                ],
              ),
            )));
  }

  ///stop the current opne loadiung screen
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
