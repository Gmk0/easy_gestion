import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CustomSize.defaultSpace),
          child: Form(
            // key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CustomText.forgotPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: CustomSize.spaceBtwItems),
                Text(
                  CustomText.forgotPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: CustomSize.spaceBtwSections * 2),
                TextFormField(
                  // controller: controller.email,
                  validator: (value) => CustomValidator.validateEmail(value),
                  decoration: const InputDecoration(
                      labelText: CustomText.email,
                      prefixIcon: Icon(Iconsax.direct_right)),
                ),
                const SizedBox(height: CustomSize.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(CustomText.submit),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
