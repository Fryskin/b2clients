// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:b2clients/features/auth/register/register.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ServiceTypePage extends StatefulWidget {
  const ServiceTypePage({super.key});

  @override
  State<ServiceTypePage> createState() => _ServiceTypePageState();
}

class _ServiceTypePageState extends State<ServiceTypePage> {
  bool _isFilterChip1Selected = false;
  bool _isFilterChip2Selected = false;

  String _documentID = '';

  List serviceType = [];
  List serviceTypes = ['Floor repair', 'Tiling work'];

  Future getDocumentId() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('accounts')
        .where('uid', isEqualTo: userUID)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              // {
              //   Map<String, dynamic> data = document.data();

              //   documentID = document.id;
              // }
              _documentID = document.id;
            }));
    await FirebaseFirestore.instance
        .collection('accounts')
        .doc(_documentID)
        .update({
      'service_types': {
        'floor_repair': _isFilterChip1Selected,
        'tiling_work': _isFilterChip2Selected
      }
    });
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
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Text(
            'What do you do?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Please, specify all your specialties, so you can find more orders.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          Column(
            children: [
              FilterChip(
                label: Text(serviceTypes[0]),
                selected: _isFilterChip1Selected,
                onSelected: (bool value) {
                  serviceType.add(serviceTypes[0]);
                  setState(() {
                    _isFilterChip1Selected = value;
                  });
                },
                onDeleted: () {
                  serviceType.remove(serviceTypes[0]);
                },
              ),
              FilterChip(
                label: Text(serviceTypes[1]),
                selected: _isFilterChip2Selected,
                onSelected: (bool value) {
                  serviceType.add(serviceTypes[1]);
                  setState(() {
                    _isFilterChip2Selected = value;
                  });
                },
                onDeleted: () {
                  serviceType.remove(serviceType[1]);
                },
              ),
            ],
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
                onPressed: () {
                  getDocumentId();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CityAndRegionPage()),
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
        ]));
  }
}
