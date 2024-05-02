import 'package:b2clients/features/auth/auth/auth.dart';
import 'package:b2clients/features/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return const HomePage();
            return const HomePage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
