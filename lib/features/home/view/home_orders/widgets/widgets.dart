import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class GetOrderDataWidget extends StatelessWidget {
  final String documentID;
  GetOrderDataWidget({super.key, required this.documentID});

  @override
  Widget build(BuildContext context) {
    FirebaseApp bissToCliForCliApp = Firebase.app('BissToCliForCli');
    FirebaseFirestore secondFirestore =
        FirebaseFirestore.instanceFor(app: bissToCliForCliApp);
    // get the collection
    CollectionReference orders = secondFirestore.collection('orders');

    return FutureBuilder<DocumentSnapshot>(
      future: orders.doc(documentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> orderData =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(orderData['title']);
        }
        return const Text('LOADING...');
      }),
    );
  }
}
