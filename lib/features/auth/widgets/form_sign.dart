import 'package:easy_gestion/features/auth/controller/sign_controller.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FormSign extends StatelessWidget {
  const FormSign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    final controller = Get.put(SignUpController());
    return Form(
        key: controller.signUpform,
        child: Column(
          children: [
            const SizedBox(height: CustomSize.spaceBtwInputFields),
            //username
            TextFormField(
              controller: controller.username,
              validator: (value) =>
                  CustomValidator.validatorEmptytext('user name', value),
              decoration: const InputDecoration(
                labelText: 'username',
                prefixIcon: Icon(Iconsax.user_edit),
              ),
            ),
            const SizedBox(height: CustomSize.spaceBtwInputFields),
            //email
            TextFormField(
              controller: controller.email,
              validator: (value) => CustomValidator.validateEmail(value),
              decoration: const InputDecoration(
                labelText: CustomText.email,
                prefixIcon: Icon(Iconsax.direct),
              ),
            ),
            const SizedBox(height: CustomSize.spaceBtwInputFields),
            //phone number
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => CustomValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                labelText: CustomText.phoneNumber,
                prefixIcon: Icon(Iconsax.call),
              ),
            ),
            const SizedBox(height: CustomSize.spaceBtwInputFields),
            //passwordj
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                validator: (value) => CustomValidator.validatePassword(value),
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
            const SizedBox(height: CustomSize.spaceBtwSections),

            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Obx(() => Checkbox(
                      value: controller.privacyPolicy.value,
                      onChanged: (value) => controller.privacyPolicy.value =
                          !controller.privacyPolicy.value)),
                ),
                const SizedBox(
                  width: CustomSize.spaceBtwItems,
                ),
                Expanded(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                        text: 'aggrer to ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: '${CustomText.privacyPolicy} ',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: dark
                                  ? CustomColors.white
                                  : CustomColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: dark
                                  ? CustomColors.white
                                  : CustomColors.primary,
                            )),
                    TextSpan(
                        text: ' et ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: CustomText.termsOfUse,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: dark
                                  ? CustomColors.white
                                  : CustomColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: dark
                                  ? CustomColors.white
                                  : CustomColors.primary,
                            )),
                  ])),
                )
              ],
            ),
            const SizedBox(
              height: CustomSize.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signUp(),
                child: const Text(CustomText.createAccount),
              ),
            )
          ],
        ));
  }
}
