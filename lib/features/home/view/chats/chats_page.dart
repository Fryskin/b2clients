// ignore_for_file: prefer_const_constructors

import 'package:b2clients/features/entrance/entrance.dart';
import 'package:b2clients/features/home/view/view.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Icons.chat_rounded,
                  size: 40,
                ),
                onPressed: () {}),
            // ACCOUNT PAGE (PROFILE)
            IconButton(
                icon: Icon(
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
