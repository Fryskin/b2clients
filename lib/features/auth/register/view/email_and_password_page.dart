// ignore_for_file: prefer_const_constructors, duplicate_ignore, sort_child_properties_last
import 'package:b2clients/features/auth/register/register.dart';
import 'package:b2clients/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirestoreService firestoreService = FirestoreService();
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (isPasswordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text);
    }

    _passwordController.clear();
    _confirmPasswordController.clear();
    // email verification
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();

    // add email and uid to account
    addEmailAndUID();
  }

  Future addEmailAndUID() async {
    // add email and uid to account
    User currentUser = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance.collection('accounts').add({
      'uid': currentUser.uid,
      'name': '',
      'surname': '',
      'email': currentUser.email,
      'create_time': currentUser.metadata.creationTime,
      'updateTime': currentUser.metadata.creationTime,
      'phone_number': '',
      'employment_type': {
        'company_member': false,
        'private_specialist': false,
      },
      'service_types': {
        'floor_repair': false,
        'tiling_work': false,
      },
      'location': {
        'city': {
          'prague': false,
        },
        'region': {
          'prague_1': false,
          'prague_2': false,
          'prague_3': false,
          'prague_4': false,
          'prague_5': false,
          'prague_6': false,
          'prague_7': false,
          'prague_8': false,
          'prague_9': false,
          'prague_10': false,
          'prague_11': false,
          'prague_12': false,
          'prague_13': false,
          'prague_14': false,
          'prague_15': false,
          'prague_16': false,
          'prague_17': false,
          'prague_18': false,
          'prague_19': false,
          'prague_20': false,
          'prague_21': false,
          'prague_22': false,
        },
      },
    });
  }

  bool isPasswordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmPasswordController.text.trim();
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
                Icon(
                  Icons.group,
                  size: 120,
                  color: Color.fromARGB(255, 18, 36, 32),
                ),

                SizedBox(
                  height: 40,
                ),
                // ignore: prefer_const_constructors

                // Register Now
                Text(
                  'Register Now!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 36, 70, 63),
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  'Just fill out a few fields below',
                  style: TextStyle(
                    color: Color.fromARGB(255, 36, 70, 63),
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),

                SizedBox(
                  height: 266,
                ),

                // Email field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 191, 206, 177)),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 149, 163, 138)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Email',
                        fillColor: Color.fromARGB(255, 232, 217, 174),
                        filled: true),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // Password field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 191, 206, 177)),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 149, 163, 138)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Password',
                        fillColor: Color.fromARGB(255, 232, 217, 174),
                        filled: true),
                    obscureText: true,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // Confirm password field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 191, 206, 177)),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 149, 163, 138)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Confirm password',
                        fillColor: Color.fromARGB(255, 232, 217, 174),
                        filled: true),
                    obscureText: true,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                // Sign up btn
                SizedBox(
                  width: 500.0,
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        // if (firestoreService.signUp(
                        //         _emailController,
                        //         _passwordController,
                        //         _confirmPasswordController,
                        //         context) ==
                        //     true) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const NameAndSurnamePage()),
                        //   );
                        // }
                        signUp();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NameAndSurnamePage()),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 232, 218, 174),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.all(20)),
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 53, 100, 92))),
                    ),
                  ),
                ),

                SizedBox(
                  height: 40,
                ),

                // Offer to RegisterPage btn
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a user?   ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 20, 39, 35),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    TextButton(
                      onPressed: widget.showLoginPage,
                      child: Text(
                        "Login",
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
}
