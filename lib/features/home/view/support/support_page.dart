// ignore_for_file: prefer_const_constructors
import 'package:b2clients/features/entrance/view/main_page.dart';
import 'package:b2clients/features/home/view/view.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
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
                  Icons.contact_support_rounded,
                  size: 40,
                ),
                onPressed: () {}),
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
