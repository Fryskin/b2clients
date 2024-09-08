import 'package:b2clients/features/export.dart';
import 'package:b2clients/features/app/chats/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatService {
  //GET INSTANCE OF ANOTHER APP DATABASE
  FirebaseFirestore getSecondFirestore() {
    FirebaseApp bissToCliForCliApp = Firebase.app('BissToCliForCli');
    FirebaseFirestore secondFirestore =
        FirebaseFirestore.instanceFor(app: bissToCliForCliApp);

    return secondFirestore;
  }

  // current user
  final FirebaseAuth _currentUser = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return getSecondFirestore()
        .collection("accounts")
        .where('users_to_chating', arrayContains: _currentUser.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  // send message

  Future<void> sendMessage(String receiverID, message) async {
    // get current user info
    final String currentUserID = _currentUser.currentUser!.uid;
    final String currentFullname =
        _currentUser.currentUser!.displayName.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderFullname: currentFullname,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID from the two users
    List<String> ids = [
      receiverID,
      currentUserID,
    ];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message to db
    await getSecondFirestore()
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userID, String secondUserID) {
    // construct chat room ID from the two users
    List<String> ids = [
      secondUserID,
      userID,
    ];
    ids.sort();
    String chatRoomID = ids.join('_');

    return getSecondFirestore()
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
