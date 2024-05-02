// ignore_for_file: prefer_const_constructors

import 'package:b2clients/features/entrance/entrance.dart';
import 'package:b2clients/features/home/view/view.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
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
                  Icons.account_balance_wallet_rounded,
                  size: 40,
                ),
                onPressed: () {}),
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
