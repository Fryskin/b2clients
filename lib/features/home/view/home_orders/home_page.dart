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

  // get document IDs
  Future getDocumentIDs() async {
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
    // document IDs

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocumentIDs(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: documentIDs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color.fromARGB(255, 255, 255, 255),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
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
                    MaterialPageRoute(builder: (context) => const ChatsPage()),
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
}
