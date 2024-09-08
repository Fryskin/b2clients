import 'package:b2clients/services/firebase_utils.dart';
import 'package:b2clients/services/simple_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeUtils {
  SimpleUtils simpleUtils = SimpleUtils();
  FirebaseUtils firebaseUtils = FirebaseUtils();
  /////////////////////////////////////////////////////////////////////////////////////////////////////// INSTANCES
  User currentUser = FirebaseAuth.instance.currentUser!;

  /////////////////////////////////////////////////////////////////////////////////////////////////////// HANDLE DATA
  int userRegisterYear =
      FirebaseAuth.instance.currentUser!.metadata.creationTime!.year;
  int userRegisterMonth =
      FirebaseAuth.instance.currentUser!.metadata.creationTime!.month;

  List monthsList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  List weekdaysList = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List numsList = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
/////////////////////////////////////////////////////////////////////////////////////////////////////////// STREAMS
  //GET ALL CHAINED ORDERS STREAM
  Stream<List<Map<String, dynamic>?>> getChainedOrdersStream() {
    return firebaseUtils
        .secondFirestore()
        .collection('orders')
        .orderBy('time_created', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final order = doc.data();

            if (order['feedbacks'].contains(currentUser.uid) &&
                !order['confirmed_feedbacks'].contains(currentUser.uid) &&
                order['time_completed'].toString().isEmpty &&
                order['time_canceled'].toString().isEmpty) {
              return order;
            } else if (order['confirmed_feedbacks'].contains(currentUser.uid) &&
                order['time_completed'].toString().isEmpty &&
                order['time_canceled'].toString().isEmpty) {
              return order;
            } else if (order['confirmed_feedbacks'].contains(currentUser.uid) &&
                order['time_completed'].toString().isNotEmpty) {
              return order;
            } else if (order['confirmed_feedbacks'].contains(currentUser.uid) &&
                order['time_canceled'].toString().isNotEmpty) {
              return order;
            }
          })
          .nonNulls
          .toList();
    });
  }

  // GET ACTIVE ORDERS STREAM
  Stream<List<Map<String, dynamic>?>> getActiveOrdersStream() {
    return firebaseUtils
        .secondFirestore()
        .collection('orders')
        .orderBy('time_created', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final order = doc.data();

            if (order['is_available_to_feedback'] ||
                order['confirmed_feedbacks'].contains(currentUser.uid)) {
              return order;
            }
          })
          .nonNulls
          .toList();
    });
  }

  // GET RESPONDED ORDERS STREAM
  Stream<List<Map<String, dynamic>?>> getRespondedOrdersStream() {
    return firebaseUtils
        .secondFirestore()
        .collection('orders')
        .orderBy('time_created', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final order = doc.data();

            if (order['feedbacks'].contains(currentUser.uid) &&
                !order['confirmed_feedbacks'].contains(currentUser.uid) &&
                order['time_completed'].toString().isEmpty &&
                order['time_canceled'].toString().isEmpty) {
              return order;
            }
          })
          .nonNulls
          .toList();
    });
  }

  // GET CONFIRMED ORDERS STREAM
  Stream<List<Map<String, dynamic>?>> getConfirmedOrdersStream() {
    return firebaseUtils
        .secondFirestore()
        .collection('orders')
        .orderBy('time_created', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final order = doc.data();

            if (order['confirmed_feedbacks'].contains(currentUser.uid) &&
                order['time_completed'].toString().isEmpty &&
                order['time_canceled'].toString().isEmpty) {
              return order;
            }
          })
          .nonNulls
          .toList();
    });
  }

  // GET COMPLETED ORDERS STREAM
  Stream<List<Map<String, dynamic>?>> getCompletedOrdersStream() {
    return firebaseUtils
        .secondFirestore()
        .collection("orders")
        .orderBy('time_created', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final order = doc.data();
            if (order['confirmed_feedbacks'].contains(currentUser.uid) &&
                order['time_completed'].toString().isNotEmpty) {
              return order;
            }
          })
          .nonNulls
          .toList();
    });
  }

  // GET CANCELED ORDERS STREAM
  Stream<List<Map<String, dynamic>?>> getCanceledOrdersStream() {
    return firebaseUtils
        .secondFirestore()
        .collection("orders")
        .orderBy('time_created', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final order = doc.data();
            if (order['confirmed_feedbacks'].contains(currentUser.uid) &&
                order['time_canceled'].toString().isNotEmpty) {
              return order;
            }
          })
          .nonNulls
          .toList();
    });
  }

  // GET ORDER STREAM
  Stream<Map<String, dynamic>?> getOrderStream(String uid, String orderID) {
    return firebaseUtils
        .secondFirestore()
        .collection("orders")
        .doc('$uid-$orderID')
        .snapshots()
        .map((snapshot) {
      return snapshot.data();
    });
  }

  // GET CLIENT STREAM
  Stream<Map<String, dynamic>?> getClientStream(String uid) {
    return firebaseUtils
        .secondFirestore()
        .collection("accounts")
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.data();
    });
  }

  Stream<Map<String, dynamic>?> getServicesStream() {
    return firebaseUtils
        .secondFirestore()
        .collection('prices')
        .doc('2XYXAOVQH4fq3l8jm349')
        .snapshots()
        .map((snapshot) {
      return snapshot.data();
    });
  }

  // GET PAGES CONTENT STREAM FOR DESCRIPTION
  Stream<Map<String, dynamic>?> getPagesContentStream() {
    return firebaseUtils
        .secondFirestore()
        .collection('pages')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final pagesContentData = doc.data();
            return pagesContentData;
          })
          .nonNulls
          .toList()
          .first;
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////// CONVERT ORDER DATA TO STRING

  // UPDATION DATE
  String getOrderDateUpdatedString(Timestamp orderTimeUpdated) {
    return '${numsList[orderTimeUpdated.toDate().day]}.${numsList[orderTimeUpdated.toDate().month]}.${orderTimeUpdated.toDate().year}';
  }

  // ADDRESS FROM LIST TO STRING
  String getOrderAddressString(List orderAddress) {
    int counter = 0;
    String orderAddressString = '';
    if (orderAddressString.toString().isEmpty) {
      for (var element in orderAddress) {
        if (counter == orderAddress.length - 1) {
          orderAddressString += simpleUtils.toTitleCase(element);
          counter++;
        } else {
          orderAddressString += '${simpleUtils.toTitleCase(element)}, ';
          counter++;
        }
      }
    }
    return orderAddressString;
  }

  // DATE TO COMPLETE 'FROM/TO'
  String getOrderDateToCompleteFromAndToString(
      Timestamp dateToCompleteFrom, Timestamp dateToCompleteTo) {
    return 'From: ${numsList[dateToCompleteFrom.toDate().day]}.${numsList[dateToCompleteFrom.toDate().month]} (${weekdaysList[dateToCompleteFrom.toDate().weekday - 1]}) - Unto: ${numsList[dateToCompleteTo.toDate().day]}.${numsList[dateToCompleteTo.toDate().month]} (${weekdaysList[dateToCompleteTo.toDate().weekday - 1]})';
  }

  // PRICE FROM/TO/SYMBOL TO ONE STRING
  String getOrderPriceString(
      int orderPriceFrom, int orderPriceTo, String orderPriceSymbol) {
    return '$orderPriceFrom $orderPriceSymbol - $orderPriceTo $orderPriceSymbol';
  }

  // CREATION DATE
  String getOrderDateCreatedString(Timestamp orderTimeCreated) {
    return '${numsList[orderTimeCreated.toDate().day]}.${numsList[orderTimeCreated.toDate().month]}.${orderTimeCreated.toDate().year}';
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////// FEEDBACK LOGIC

  Future sendFeedback(
      String orderDocumentID,
      List orderFeedbacksList,
      String orderID,
      String orderServiceType,
      String orderHolderName,
      String orderUID,
      String clientEmail,
      String clientLanguageCode) async {
    orderFeedbacksList.add(currentUser.uid);
    firebaseUtils.updateOrderData(orderDocumentID, {
      'feedbacks': orderFeedbacksList,
    });
    firebaseUtils.sendMailOrderHasRespond(clientEmail, orderHolderName, orderID,
        simpleUtils.toTitleCase(orderServiceType), clientLanguageCode);
  }

  Future cancelFeedback(String orderDocumentID, List orderFeedbacksList) async {
    orderFeedbacksList.remove(currentUser.uid);
    firebaseUtils.updateOrderData(orderDocumentID, {
      'feedbacks': orderFeedbacksList,
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////////
}
