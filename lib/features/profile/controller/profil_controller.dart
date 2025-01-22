import 'package:easy_gestion/common/widgets/loader_class.dart';
import 'package:easy_gestion/data/authentification.dart';
import 'package:easy_gestion/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilController extends GetxController {
  final userName = TextEditingController();
  final email = TextEditingController();
  GlobalKey<FormState> updateForm = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    email.text = UserRepository.Instance.user.value.email;
    userName.text = UserRepository.Instance.user.value.username;
  }

  Future<void> updateUser() async {
    try {
      //TFullScreenLoader.openLoading('login', CustomImage.animation);

      // final isConnected = await NetworkManager.instance.isConnected();

      if (!updateForm.currentState!.validate()) return;

      var data = {
        "username": userName.text,
      };

      await UserRepository.Instance.updateSingleField(data);

      UserRepository.Instance.user.value.username = userName.text;

      TLoaders.successSnackBar(
          title: 'Success', message: "Modification reussie");
    } catch (e) {
      // TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }
  //TFullScreenLoader.stopLoading();
}
