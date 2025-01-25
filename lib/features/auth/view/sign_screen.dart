import 'package:easy_gestion/features/auth/widgets/form_sign.dart';
import 'package:easy_gestion/features/auth/widgets/login_widgets.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CustomSize.defaultSpace),
          child: Column(
            children: [
              Text(CustomText.signUpTitle,
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: CustomSize.spaceBtwSections),
              const FormSign(),
              const SizedBox(
                height: CustomSize.spaceBtwSections,
              ),
              const FormDivider(
                dividerText: 'ou continuer avec ',
              ),
              const SizedBox(
                height: CustomSize.spaceBtwSections,
              ),
              const LoginProvider(),
            ],
          ),
        ),
      ),
    );
  }
}
