import 'package:easy_gestion/common/styles/spacing_styles.dart';
import 'package:easy_gestion/features/auth/widgets/login_widgets.dart';
import 'package:easy_gestion/utils/export.dart';
import 'package:easy_gestion/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CustomHelperFunctions.isDarkMode(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: CustomSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            LoginHeader(dark: dark),
            const LoginForm(),
            const FormDivider(
              dividerText: CustomText.orSignWith,
            ),

            const SizedBox(height: CustomSize.spaceBtwSections),
            //footer
            const LoginProvider()
          ],
        ),
      ),
    ));
  }
}
