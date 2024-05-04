import 'package:b2clients/features/auth/register/register.dart';
import 'package:b2clients/features/home/view/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<String> documentIDs = [];
  dynamic userName;
  // List employmentTypes = [];
  dynamic isEmploymentTypeContainsTrue;
  dynamic isServiceTypesContainsTrue;
  dynamic isCityOrRegionContainsTrue;

  Future getAccountData() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('accounts')
        .where('uid', isEqualTo: userUID)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              // CHECK NAME/SURNAME
              Map<String, dynamic> data = document.data();
              userName = data['name'];

              // CHECK EMPLOYMENT TYPE
              Map<String, dynamic> employmentType =
                  document.data()['employment_type'];
              // Iterable<String> keys = employmentType.keys;
              // for (String key in keys) {
              //   employmentTypes.add(employmentType[key]);
              // }
              isEmploymentTypeContainsTrue =
                  employmentType.values.contains(true);

              // CHECK SERVICE TYPES
              Map<String, dynamic> serviceTypes =
                  document.data()['service_types'];
              isServiceTypesContainsTrue = serviceTypes.values.contains(true);

              // CHECK CITY AND REGION
              Map<String, dynamic> cityAndRegion = document.data()['location'];
              Iterable<String> keys = cityAndRegion.keys;
              for (String key in keys) {
                Map<String, dynamic> keyKeys = cityAndRegion[key];
                isCityOrRegionContainsTrue = keyKeys.values.contains(true);
              }
            }));
  }

  // get document IDs
  Future getOrdersDocumentIDs() async {
    FirebaseApp bissToCliForCliApp = Firebase.app('BissToCliForCli');
    FirebaseFirestore secondFirestore =
        FirebaseFirestore.instanceFor(app: bissToCliForCliApp);

    await secondFirestore
        .collection('orders')
        .where('serviceTypes',
            isEqualTo: {'tiling_work': true, 'floor_repair': false})
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference.id);
              documentIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAccountData(),
      builder: (context, snapshot) {
        if (userName == '') {
          return const NameAndSurnamePage();
        }
        if (!isEmploymentTypeContainsTrue) {
          return const EmploymentTypePage();
        }
        if (!isServiceTypesContainsTrue) {
          return const ServiceTypePage();
        }
        if (!isCityOrRegionContainsTrue) {
          return const CityAndRegionPage();
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: getOrdersDocumentIDs(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: documentIDs.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: GetOrderDataWidget(
                                        documentID: documentIDs[index],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // SUPPORT PAGE
                  IconButton(
                      icon: const Icon(
                        Icons.contact_support_outlined,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SupportPage()),
                        );
                      }),
                  // BALANCE PAGE
                  IconButton(
                      icon: const Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BalancePage()),
                        );
                      }),
                  // ORDERS PAGE (HOME PAGE)
                  IconButton(
                      icon: const Icon(
                        Icons.task_rounded,
                        size: 40,
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const MainPage()),
                        // );
                      }),
                  // CHATS PAGE
                  IconButton(
                      icon: const Icon(
                        Icons.chat_outlined,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatsPage()),
                        );
                      }),
                  // ACCOUNT PAGE (PROFILE)
                  IconButton(
                      icon: const Icon(
                        Icons.account_circle_outlined,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountPage()),
                        );
                      }),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
