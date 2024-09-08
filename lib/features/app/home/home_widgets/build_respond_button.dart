import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class RespondButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final List orderFeedbacksList;
  final List orderConfirmedFeedbacksList;
  final String orderDocumentID;
  final String orderID;
  final String orderServiceType;
  final String orderHolderName;
  final String orderUID;
  final String clientName;
  final String clientSurname;
  final String clientEmail;
  final String clientLanguageCode;

  const RespondButtonWidget(
      {super.key,
      required this.clientLanguageCode,
      required this.onTap,
      required this.orderFeedbacksList,
      required this.orderConfirmedFeedbacksList,
      required this.orderDocumentID,
      required this.orderID,
      required this.orderServiceType,
      required this.orderHolderName,
      required this.orderUID,
      required this.clientName,
      required this.clientSurname,
      required this.clientEmail});

  @override
  Widget build(BuildContext context) {
    HomeUtils homeUtils = HomeUtils();

    if (orderFeedbacksList.contains(homeUtils.currentUser.uid)) {
      return orderConfirmedFeedbacksList.contains(homeUtils.currentUser.uid)
          ? BuildSingleButton(
              title: 'Chat with client',
              titleColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(
                            receiverID: orderUID,
                            receiverName: clientName,
                            receiverSurname: clientSurname,
                          )),
                );

                onTap;
              },
            )
          : BuildSingleButton(
              title: 'Cancel respond',
              titleColor: Colors.red,
              onPressed: () {
                homeUtils.cancelFeedback(orderDocumentID, orderFeedbacksList);
                onTap;
              });
    }
    return BuildSingleButton(
      title: 'Respond',
      titleColor: Colors.white,
      onPressed: () async {
        await homeUtils.sendFeedback(
            orderDocumentID,
            orderFeedbacksList,
            orderID,
            orderServiceType,
            orderHolderName,
            orderUID,
            clientEmail,
            clientLanguageCode);

        onTap;
      },
    );
  }
}
