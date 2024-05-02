import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String ducumentID;

  GetUserName({required this.ducumentID});

  @override
  Widget build(BuildContext context) {
    CollectionReference accounts =
        FirebaseFirestore.instance.collection('accounts');

    return FutureBuilder<DocumentSnapshot>(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(data['name']);
        }
        return Text('Processing...');
      }),
      future: null,
    );
  }
}
