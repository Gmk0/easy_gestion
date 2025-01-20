import 'package:easy_gestion/common/skeleton/list_ventes_skeleton.dart';
import 'package:easy_gestion/common/widgets/balance_compte.dart';
import 'package:easy_gestion/common/widgets/build_icon_button.dart';
import 'package:easy_gestion/common/widgets/liste_transac.dart';
import 'package:easy_gestion/common/widgets/section_heading.dart';
import 'package:easy_gestion/data/authentification.dart';
import 'package:easy_gestion/data/data.dart';
import 'package:easy_gestion/data/repositories/hitstory_transaction_repository.dart';
import 'package:easy_gestion/data/repositories/user_repository.dart';
import 'package:easy_gestion/features/onBoarding/view/home/controller/home_controller.dart';
import 'package:easy_gestion/features/operation/view/depenses.dart';
import 'package:easy_gestion/features/operation/view/reapprovisionnement.dart';
import 'package:easy_gestion/features/operation/view/ventes_jour.dart';

import 'package:easy_gestion/utils/export.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    //final authUser = UserRepository.Instance.fetchUserDetails();
    //  final darkMode = CustomHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.grey),
                    borderRadius: BorderRadius.circular(100)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: const Image(
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                    image: AssetImage(CustomImage.lighAppLogo),
                  ),
                ),
              ),
              const SizedBox(
                width: CustomSize.sm,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcom back',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text("brigitte",
                      style: TextStyle(
                        fontSize: 12,
                      ))
                ],
              )
            ],
          ),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CustomSize.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //balance

              StreamBuilder<double>(
                stream: HistoryTransactionRepository.instance
                    .getTotalAmountStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return BalanceCompteShimer(); // Ou n'importe quel widget de chargement
                  }
                  if (snapshot.hasError) {
                    return Text('Erreur : ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return Text('Aucune donnée disponible');
                  }

                  return BalanceCompte(
                    totalBalance: snapshot.data!,
                  );
                },
              ),

              const SizedBox(
                height: CustomSize.spaceBtwItems,
              ),
              /*
              SectionHeading(
                title: 'All credit cards (2)',
                showActionButton: true,
                onPressed: () => Get.to(() => const MesCartes()),
              ), */
              const SizedBox(
                height: CustomSize.spaceBtwItems,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(CustomSize.md),
                ),
                // color: Colors.blue,
                child: SizedBox(
                  child: Container(),
                ),
              ),
              // card credit
              const SizedBox(
                height: CustomSize.spaceBtwSections,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildIconButton(
                    icon: Iconsax.document_download,
                    label: 'Ventes du jour',
                    onPressed: () => Get.to(() => VentesJour()),
                  ),
                  BuildIconButton(
                    icon: Iconsax.money_change,
                    label: "Reapprovisionement",
                    onPressed: () => Get.to(() => Reapprovisionnement()),
                  ),
                  BuildIconButton(
                    icon: Iconsax.bank,
                    label: 'Depenses',
                    onPressed: () => Get.to(() => Depenses()),
                  ),
                ],
              ),
              const SizedBox(
                height: CustomSize.spaceBtwSections,
              ),
              SectionHeading(
                title: 'Dernier  transaction',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(
                height: CustomSize.spaceBtwItems,
              ),

              Obx(() {
                if (controller.isLoading.value) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView(
                      shrinkWrap: true,
                      children: elements
                          .map(
                            (item) => ListeTransac(
                              icon: "string",
                              title: item['title'],
                              subtitle: item['subtitle'],
                              date: '21/03/2023',
                              price: 2000.0,
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
                return Column(
                  children: controller.lastTransaction.value
                      .take(5)
                      .map(
                        (item) => ListeTransac(
                          icon: item.product!.background,
                          title: item.product!.label,
                          date: DateFormat('dd-MM-yyyy').format(item.date),
                          subtitle: "ventes",
                          price: item.totalAmount,
                          //trailing: Text(item['price']),
                        ),
                      )
                      .toList(),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
