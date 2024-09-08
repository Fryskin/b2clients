import 'package:b2clients/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatBuble extends StatelessWidget {
  final String message;
  final bool addSpace;
  final bool isUserCurrent;
  final Timestamp timestamp;
  final bool isSenderIsCrrentUser;
  final bool isRead;

  ChatBuble(
      {super.key,
      required this.isSenderIsCrrentUser,
      required this.isRead,
      required this.addSpace,
      required this.isUserCurrent,
      required this.message,
      required this.timestamp});

  String timestampHourTostring() {
    if (timestamp.toDate().hour < 10) {
      return '0${timestamp.toDate().hour}';
    } else {
      return timestamp.toDate().hour.toString();
    }
  }

  String timestampMinuteTostring() {
    if (timestamp.toDate().minute < 10) {
      return '0${timestamp.toDate().minute}';
    } else {
      return timestamp.toDate().minute.toString();
    }
  }

  Icon? isReadIcon() {
    return isSenderIsCrrentUser && !isRead
        ? const Icon(
            Icons.done_rounded,
            size: 15,
          )
        : isSenderIsCrrentUser && isRead
            ? const Icon(
                Icons.done_all_rounded,
                size: 15,
              )
            : null;
  }

  PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: isUserCurrent
              ? BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(10))
              : BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(20)),
          color: isUserCurrent ? theme.pastelYellow() : theme.pastelBlue()),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: isUserCurrent
          ? EdgeInsets.only(
              top: addSpace ? 6 : 2, bottom: 0, left: 60, right: 10)
          : EdgeInsets.only(
              top: addSpace ? 6 : 2, bottom: 0, left: 10, right: 60),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(child: theme.bodyTitleSettings(message)),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: theme.timestampText(
                '${timestampHourTostring()}:${timestampMinuteTostring()}'),
          ),
          isReadIcon() ?? Column()
        ],
      ),
    );
  }
}
