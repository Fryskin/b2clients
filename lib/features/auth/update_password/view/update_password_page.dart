// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatefulWidget {
  // final VoidCallback showLoginPage;
  final VoidCallback showLoginPage2;

  const UpdatePasswordPage({super.key, required this.showLoginPage2});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('We have successfully sent you an email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(e.message.toString()));
          });
    }

    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 128, 206, 191),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors

                // Greeting
                const Text(
                  'Update your password',
                  style: TextStyle(
                    color: Color.fromARGB(255, 36, 70, 63),
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Text(
                  'Enter your email and you will receive a link to update your password',
                  style: TextStyle(
                    color: Color.fromARGB(255, 36, 70, 63),
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(
                  height: 285,
                ),
                TextButton(
                  onPressed: widget.showLoginPage2,
                  child: const Text(
                    "I changed my mind",
                    style: TextStyle(
                        color: Color.fromARGB(255, 52, 110, 101),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // Email field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 191, 206, 177)),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 149, 163, 138)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Email',
                        fillColor: const Color.fromARGB(255, 232, 217, 174),
                        filled: true),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                  width: 500.0,
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ElevatedButton(
                      onPressed: passwordReset,
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.all(20)),
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 53, 100, 92))),
                      child: const Text(
                        'Send link',
                        style: TextStyle(
                          color: Color.fromARGB(255, 232, 218, 174),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
