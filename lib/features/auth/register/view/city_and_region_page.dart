import 'package:b2clients/features/entrance/entrance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CityAndRegionPage extends StatefulWidget {
  const CityAndRegionPage({super.key});

  @override
  State<CityAndRegionPage> createState() => _CityAndRegionPageState();
}

class _CityAndRegionPageState extends State<CityAndRegionPage> {
  List regionList = ['praga_1', 'praga_2', 'praga_3'];
  List boolList = [false, false, false];
  int region = 1;

  String _documentID = '';

  Future getDocumentId() async {
    for (int i = 0; i < regionList.length; i++) {
      if (regionList[i].contains(region.toString())) {
        boolList[i] = true;
      }
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
      'location': {
        'prague': true,
        'region': {
          'prague_1': boolList[0],
          'prague_2': boolList[1],
          'prague_3': boolList[2]
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // int dropdownValue = 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Registration',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Container(
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Text('Select city which in you live'),
              //     PopupMenuButton(
              //       itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              //         PopupMenuItem(
              //           onTap: () {
              //             city = true;
              //           },
              //           child: ListTile(
              //             title: Text('Prague'),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  const Text('Select region of city which in you live'),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      for (int i = 1; i <= 3; i++)
                        PopupMenuItem(
                          onTap: () {
                            region = i;
                          },
                          child: ListTile(
                            title: Text('Prague $i'),
                          ),
                        ),
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
                            builder: (context) => const MainPage()),
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
        ),
      ),
    );
  }
}
