import 'package:easy_gestion/common/widgets/button_with_loading.dart';
import 'package:easy_gestion/features/auth/controller/login_controller.dart';
import 'package:easy_gestion/features/auth/view/forgot_password.dart';
import 'package:easy_gestion/features/auth/view/sign_screen.dart';

import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginProvider extends StatelessWidget {
  const LoginProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: CustomColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => controller.googleSign(),
            icon: const Image(
              width: CustomSize.iconsMd,
              height: CustomSize.iconsMd,
              image: AssetImage(CustomImage.google),
            ),
          ),
        ),
        const SizedBox(width: CustomSize.spaceBtwItems),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginform,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: CustomSize.spaceBtwSections,
        ),
        child: Column(
          children: [
            TextFormField(
              validator: (value) => CustomValidator.validateEmail(value),
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: CustomText.email,
              ),
            ),
            const SizedBox(height: CustomSize.spaceBtwInputFields),
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                //validator: (value) => CustomValidator.validatePassword(value),
                decoration: InputDecoration(
                  labelText: CustomText.password,
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye)),
                  prefixIcon: Icon(Iconsax.password_check),
                ),
              ),
            ),
            const SizedBox(height: CustomSize.spaceBtwInputFields / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.remeberMe.value,
                        onChanged: (value) => controller.remeberMe.value =
                            !controller.remeberMe.value)),
                    const Text(CustomText.rememberMe)
                  ],
                ),
                Expanded(
                  child: TextButton(
                      onPressed: () => Get.to(() => ForgetPassword()),
                      child: const Text(CustomText.forgotPassword)),
                ),
              ],
            ),
            const SizedBox(
              height: CustomSize.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ButtonWithLoad(
                controller: () => controller.signIn(),
                label: 'Login',
              ),
            ),
            const SizedBox(
              height: CustomSize.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => SignUpScreen()),
                child: const Text(CustomText.createAccount),
              ),
            ),
            const SizedBox(
              height: CustomSize.spaceBtwSections,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 50,
          image: AssetImage(dark ? CustomImage.logoApp : CustomImage.logoApp),
        ),
        Text(CustomText.welcomeBackTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: CustomSize.sm),
        Text(CustomText.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key,
    required this.dividerText,
  });
  final String dividerText;
  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
          color: dark ? CustomColors.darkGrey : CustomColors.grey,
          thickness: 0.5,
          indent: 60,
          endIndent: 5,
        )),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
            child: Divider(
          color: dark ? CustomColors.darkGrey : CustomColors.grey,
          thickness: 0.5,
          indent: 60,
          endIndent: 5,
        )),
      ],
    );
  }
}
