import 'package:easy_gestion/common/widgets/loader_class.dart';
import 'package:easy_gestion/data/authentification.dart';
import 'package:easy_gestion/data/repositories/user_repository.dart';
import 'package:easy_gestion/features/navigation/nav_screen.dart';
import 'package:easy_gestion/model/user_model.dart';
import 'package:easy_gestion/utils/constants/image_strings.dart';
import 'package:easy_gestion/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstname = TextEditingController();
  final phoneNumber = TextEditingController();
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  GlobalKey<FormState> signUpform = GlobalKey<FormState>();

  Future<void> signUp() async {
    try {
      TFullScreenLoader.openLoading(
          'we are proccessiong your informatio', CustomImage.animation);

      //final isConnected = await NetworkManager.instance.isConnected();

      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Accept privacy policy',
            message: 'In order to create acount');
        return;
      }

      //Register user in tehe firebase authentication

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      final newUser = UserModel(
          id: userCredential.user!.uid,
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //remove loader

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Congratulations!',
          message: 'your account has been created verify email to contine');

      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }
}
