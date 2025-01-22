import 'package:easy_gestion/common/widgets/loader_class.dart';
import 'package:easy_gestion/data/authentification.dart';
import 'package:easy_gestion/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:easy_gestion/utils/constants/image_strings.dart';
import 'package:easy_gestion/utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  //variables

  final remeberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginform = GlobalKey<FormState>();

  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> signIn() async {
    try {
      //TFullScreenLoader.openLoading('login', CustomImage.animation);

      // final isConnected = await NetworkManager.instance.isConnected();

      if (!loginform.currentState!.validate()) return;

      if (remeberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      //Register user in tehe firebase authentication

      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //remove loader

      //TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      //TFullScreenLoader.stopLoading();
    }
  }

  Future<void> googleSign() async {
    try {
      TFullScreenLoader.openLoading('logging you in', CustomImage.animation);

      // final isConnected = await NetworkManager.instance.isConnected();

      final userCredentials =
          await AuthenticationRepository.instance.signiWithGoole();

      final userRepository = Get.put(UserRepository());

      await userRepository.saveUserRecordWithGoogle(userCredentials);

      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'oH Snap', message: e.toString());
    }
  }
}
