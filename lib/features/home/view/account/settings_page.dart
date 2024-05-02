import 'package:b2clients/features/entrance/view/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 500.0,
              height: 48,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ElevatedButton(
                  onPressed: () {
                    signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  },
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.all(20)),
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 53, 100, 92))),
                  child: const Text(
                    'Sign out',
                    style: TextStyle(
                      color: Color.fromARGB(255, 232, 218, 174),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
