// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:b2clients/features/auth/register/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmploymentTypePage extends StatefulWidget {
  const EmploymentTypePage({super.key});

  @override
  State<EmploymentTypePage> createState() => _EmploymentTypePageState();
}

class _EmploymentTypePageState extends State<EmploymentTypePage> {
  int _selectedValue = 1;
  bool privateSpecialist = false;
  bool companyMember = false;
  String _documentID = '';

  Future getDocumentId() async {
    if (_selectedValue == 1) {
      privateSpecialist = true;
      companyMember = false;
    } else {
      privateSpecialist = false;
      companyMember = true;
    }
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
      'employment_type': {
        'private_specialist': privateSpecialist,
        'company_member': companyMember
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
      body: Column(
        children: <Widget>[
          Column(
            children: [
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: _selectedValue,
                    activeColor: Color.fromARGB(255, 0, 0, 0),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue =
                            value!; // Update _selectedValue when option 1 is selected
                      });
                    },
                  ),
                  Text('Private specialist'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: _selectedValue,
                    activeColor: Color.fromARGB(255, 0, 0, 0),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue =
                            value!; // Update _selectedValue when option 1 is selected
                      });
                    },
                  ),
                  Text('Company member'),
                ],
              ),
            ],
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
                        builder: (context) => const ServiceTypePage()),
                  );
                },
                child: Text(
                  'Next',
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
        ],
      ),
    );
  }
}
