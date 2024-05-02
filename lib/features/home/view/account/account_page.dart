// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:html';

import 'package:b2clients/features/entrance/entrance.dart';

import 'package:b2clients/features/home/view/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String userNameAndSurname = '';

  Future getDocumentId() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('accounts')
        .where('uid', isEqualTo: userUID)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              Map<String, dynamic> data = document.data();
              userNameAndSurname = '${data['name']} ${data['surname']}';
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 245, 248),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              icon: Icon(Icons.settings))
        ],
        title: Text('Account'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: [
            Card(
              color: Color.fromARGB(255, 255, 255, 255),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FutureBuilder(
                      future: getDocumentId(),
                      builder: (context, snapshot) {
                        return Text(userNameAndSurname);
                      },
                    ),
                  ),
                ],
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
                icon: Icon(
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
                icon: Icon(
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
                icon: Icon(
                  Icons.task_outlined,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                }),
            // CHATS PAGE
            IconButton(
                icon: Icon(
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
                icon: Icon(
                  Icons.account_circle_rounded,
                  size: 40,
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
