import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  final VoidCallback showUpdatePasswordPage;
  // final VoidCallback showUpdatePasswordPage;
  const LoginPage({
    super.key,
    required this.showRegisterPage,
    required this.showUpdatePasswordPage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    // print(FirebaseAuth.instance.currentUser!.metadata.creationTime.);

    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                const Icon(
                  Icons.group,
                  size: 120,
                  color: Color.fromARGB(255, 18, 36, 32),
                ),

                const SizedBox(
                  height: 40,
                ),
                // ignore: prefer_const_constructors

                // Greeting
                const Text(
                  'Greetings!',
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
                  'Wellcome to B2C4B, the best platform in CZ!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 36, 70, 63),
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(
                  height: 277,
                ),
                TextButton(
                  onPressed: widget.showUpdatePasswordPage,
                  child: const Text(
                    "I forgot my password, which I definitely wrote down",
                    style: TextStyle(
                      color: Color.fromARGB(255, 52, 110, 101),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 22,
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

                // Password field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _passwordController,
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
                        hintText: 'Password',
                        fillColor: const Color.fromARGB(255, 232, 217, 174),
                        filled: true),
                    obscureText: true,
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
                      onPressed: signIn,
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.all(20)),
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 53, 100, 92))),
                      child: const Text(
                        'Sign in',
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
                // Offer to register btn
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not a user yet?   ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 20, 39, 35),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    TextButton(
                      onPressed: widget.showRegisterPage,
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                          color: Color.fromARGB(255, 52, 110, 101),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
}
