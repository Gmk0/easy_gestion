import 'package:easy_gestion/features/auth/controller/forgot_password_controller.dart';
import 'package:easy_gestion/features/auth/view/login_screen.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CustomSize.defaultSpace),
          child: Column(
            children: [
              Image(
                image: const AssetImage(CustomImage.onBaordingImage1),
                width: CustomHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: CustomSize.spaceBtwSections),

              //title et subtile

              Text(
                email,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CustomSize.spaceBtwItems),
              Text(
                CustomText.changePasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CustomSize.spaceBtwItems),
              Text(
                CustomText.changePasswordSubTitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CustomSize.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text(CustomText.done),
                ),
              ),
              const SizedBox(height: CustomSize.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () =>
                      ForgotPasswordController.Instance.resendPasswordLink(
                          email),
                  child: const Text(CustomText.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
