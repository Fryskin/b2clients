// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:b2clients/features/auth/register/register.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class NameAndSurnamePage extends StatefulWidget {
  const NameAndSurnamePage({super.key});

  @override
  State<NameAndSurnamePage> createState() => _NameAndSurnamePageState();
}

class _NameAndSurnamePageState extends State<NameAndSurnamePage> {
  bool isChecked = false;
  bool isUserAgree = false;
  String _documentID = '';

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();

    super.dispose();
  }

  // get user account document ID
  Future addAcountInfo() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;

    // get document id
    await FirebaseFirestore.instance
        .collection('accounts')
        .where('uid', isEqualTo: userUID)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              _documentID = document.id;
            }));
    // add new info to fields in account
    await FirebaseFirestore.instance
        .collection('accounts')
        .doc(_documentID)
        .update({
      'name': _nameController.text.trim(),
      'surname': _surnameController.text.trim(),
    });
    _nameController.clear();
    _surnameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Registration',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'What is your name?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Please, enter your name and surname form id card, this is very important for verification.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _nameController,
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
                  hintText: 'Name',
                  fillColor: const Color.fromARGB(255, 232, 217, 174),
                  filled: true),
              // obscureText: true,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _surnameController,
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
                  hintText: 'Surname',
                  fillColor: const Color.fromARGB(255, 232, 217, 174),
                  filled: true),
              // obscureText: true,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  value: isChecked,
                  onChanged: (bool? value) {
                    isUserAgree = !isUserAgree;

                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'I accept the public offer, terms of use, privacy policy',
                    style: TextStyle(
                      inherit: true,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 500.0,
            height: 48,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ElevatedButton(
                onPressed: () {
                  addAcountInfo();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmploymentTypePage()),
                  );
                },
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.all(20)),
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 53, 100, 92))),
                child: const Text(
                  'Next',
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
    );
  }
}
