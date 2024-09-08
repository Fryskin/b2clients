import 'package:cloud_firestore/cloud_firestore.dart';

class SupportUtils {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// GET QUESTION MAP STREAM
  Stream<Map<String, dynamic>?> getQuestionsStream() {
    return _firestore
        .collection("support")
        .doc('bwkSDsyUSjm1AEU8JY9D')
        .snapshots()
        .map((snapshot) {
      return snapshot.data();
    });
  }
}
