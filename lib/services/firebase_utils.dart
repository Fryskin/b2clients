import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:translator_plus/translator_plus.dart';

class FirebaseUtils {
// FIRESTORE FROM ANOTHER APP
  FirebaseFirestore secondFirestore() {
    FirebaseApp bissToCliForCliApp = Firebase.app('BissToCliForCli');
    FirebaseFirestore secondFirestore =
        FirebaseFirestore.instanceFor(app: bissToCliForCliApp);
    return secondFirestore;
  }

  Future updateUserAccountData(dynamic data) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('accounts')
        .doc(currentUser.uid)
        .update(data);
  }

  // GET CLIENT ACCOUNT DATA
  dynamic getClientAccountData(String userID) async {
    await secondFirestore()
        .collection('accounts')
        .doc(userID)
        .get()
        .then((snapshot) {
      return snapshot.data();
    });
  }

  // GET ORDER DATA
  dynamic getOrderData(String orderDocumentID) async {
    await secondFirestore()
        .collection('orders')
        .doc(orderDocumentID)
        .get()
        .then((snapshot) {
      return snapshot.data();
    });
  }

  // UPDATE ORDER DATA

  dynamic updateOrderData(String orderDocumentID, dynamic data) async {
    await secondFirestore()
        .collection('orders')
        .doc(orderDocumentID)
        .update(data);
  }

  //GET WORKER ACCOUNT DATA
  dynamic getAccountData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    dynamic data;
    await FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .get()
        .then((snapshot) => data = snapshot.data());
    return data;
  }

  //SIGN OUT
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //DELETE ACCOUNT
  Future deleteAccount() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future addServiceTypes(List userServiceTypesList) async {
    updateUserAccountData({'service_types': userServiceTypesList});
  }

  //////////////////////////////////////////////////////////////////////////////////////////// MAILING
  //SEND MAIL WHEN ORDER CREATED

  Future sendMailOrderHasRespond(String recipientEmail, String recipientName,
      String orderID, String title, String clientLanguageCode) async {
    String username = 'b2c.app.notification@gmail.com';
    String password = 'repxxmhtxzdfemwy';

    Translation mailText =
        await ('We inform you, $recipientName, that your order has a new one respond, check your app!')
            .translate(to: clientLanguageCode);
    Translation mailSubject =
        await ('Order №$orderID "$title" has a new one respond')
            .translate(to: clientLanguageCode);
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'B2C Team')
      ..recipients.add(recipientEmail)
      ..subject = mailSubject.text
      ..text = mailText.text;
    try {
      final sendReport = await send(message, smtpServer);
      print('Mesage sent: ${sendReport.toString()}');
    } on MailerException catch (exception) {
      print('Message wasnt sent.');
      print(exception.message);
      for (var problem in exception.problems) {
        print('Problem: ${problem.code}: ${problem.msg}');
      }
    }
  }
}
