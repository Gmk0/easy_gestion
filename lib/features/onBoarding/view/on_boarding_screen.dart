import 'package:easy_gestion/features/auth/view/login_screen.dart';
import 'package:easy_gestion/features/navigation/nav_screen.dart';
import 'package:easy_gestion/features/onBoarding/view/home/view/home.dart';
import 'package:flutter/material.dart';

import 'package:easy_gestion/utils/constants/image_strings.dart';
import 'package:easy_gestion/utils/constants/sizes.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _controller,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              OnboardingPage(
                image: CustomImage
                    .imageOnboarding2[0], // Replace with your image link
                title: 'Paiement le plus rapide en RDC',
                description:
                    'Intégrez plusieurs méthodes de paiement pour vous aider à accélérer le processus',
              ),
              OnboardingPage(
                image: CustomImage
                    .imageOnboarding2[0], // Replace with your image link
                title: 'La plateforme la plus sécurisée pour le client',
                description:
                    'Empreinte digitale intégrée, reconnaissance faciale et bien plus encore, pour une sécurité totale',
              ),
              OnboardingPage(
                image: CustomImage
                    .imageOnboarding2[0], // Replace with your image link
                title: 'Payer pour tout est simple et pratique',
                description:
                    'Empreinte digitale intégrée, reconnaissance faciale et bien plus encore, pour une sécurité totale',
              ),
            ],
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => buildDot(index, context),
                  ),
                ),
                // SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(CustomSize.md),
          child: ElevatedButton(
            child: Text(_currentPage == 2 ? 'Commencer' : 'Suivant'),
            onPressed: () {
              if (_currentPage != 2) {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              } else {
                Get.offAll(LoginScreen());
                // Navigate to the next screen
              }
            },
          )),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: _currentPage == index ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage(
      {required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CustomSize.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(image, height: 300), // Using network image
          const SizedBox(height: CustomSize.md),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CustomSize.defaultSpace),
          Text(
            description,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
