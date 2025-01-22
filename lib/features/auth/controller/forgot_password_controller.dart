import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:easy_gestion/common/widgets/loader_class.dart';
import 'package:easy_gestion/data/authentification.dart';
import 'package:easy_gestion/features/auth/view/reset_password.dart';
import 'package:easy_gestion/utils/constants/image_strings.dart';
import 'package:easy_gestion/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get Instance => Get.find();

  final email = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  sendPasswordLink() async {
    try {
      TFullScreenLoader.openLoading('login', CustomImage.animation);
      final isConnected = await ConnectivityWrapper.instance.isConnected;

      if (!isConnected) {
        TFullScreenLoader.stopLoading();

        TLoaders.errorSnackBar(
            title: 'Oh snap', message: "vous n'etes pas connecter a internet");
        return;
      }

      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendEmailPasswordRest(email.text.trim());

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'email sent', message: 'l email a ete bien sent');

      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'oh snap', message: e.toString());
    }
  }

  resendPasswordLink(String email) async {
    try {
      TFullScreenLoader.openLoading('login', CustomImage.animation);

      final isConnected = await ConnectivityWrapper.instance.isConnected;

      if (!isConnected) {
        TFullScreenLoader.stopLoading();

        TLoaders.errorSnackBar(
            title: 'Oh snap', message: "vous n'etes pas connecter a internet");
        return;
      }

      await AuthenticationRepository.instance.sendEmailPasswordRest(email);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'email sent', message: 'l email a ete bien sent');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'oh snap', message: e.toString());
    }
  }
}
