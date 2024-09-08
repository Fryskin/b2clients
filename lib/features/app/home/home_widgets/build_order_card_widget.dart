// ignore_for_file: prefer_const_constructors

import 'package:b2clients/features/export.dart';
import 'package:b2clients/services/simple_utils.dart';
import 'package:b2clients/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildOrderCardWidget extends StatefulWidget {
  final String orderUID;
  final String orderID;
  final void Function()? onTap;
  const BuildOrderCardWidget({
    super.key,
    this.onTap,
    required this.orderUID,
    required this.orderID,
  });

  @override
  State<BuildOrderCardWidget> createState() => _BuildOrderCardWidgetState();
}

class _BuildOrderCardWidgetState extends State<BuildOrderCardWidget> {
  SimpleUtils simpleUtils = SimpleUtils();
  HomeUtils homeUtils = HomeUtils();
  PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: homeUtils.getOrderStream(widget.orderUID, widget.orderID),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text('error');
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center();
          }
          Map<String, dynamic>? orderData = snapshot.data!;
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Card(
              shape: theme.cardShapeBorderOnly(),
              color: theme.cardColorWhite(),
              shadowColor: theme.cardColorWhite(),
              surfaceTintColor: theme.cardColorWhite(),
              elevation: 5,
              margin: EdgeInsets.all(0),
              child: Column(
                children: [
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    // minVerticalPadding: 1,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        theme
                            .userNameTitle(simpleUtils
                                .toTitleCase(orderData['service_type']))
                            .translate(''),
                        theme.defaultText(homeUtils.getOrderDateUpdatedString(
                            orderData['time_updated'])),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildOrderIconedInfo(
                            orderData,
                            Icons.payments_outlined,
                            homeUtils.getOrderPriceString(
                                orderData['price']['from'],
                                orderData['price']['to'],
                                orderData['price']['symbol'])),
                        buildOrderIconedInfo(
                            orderData,
                            Icons.home_work_outlined,
                            homeUtils.getOrderAddressString(
                                orderData['location']['city']['prague']
                                    ['areas'])),
                        buildOrderIconedInfo(
                            orderData,
                            Icons.calendar_month,
                            homeUtils.getOrderDateToCompleteFromAndToString(
                                orderData['date_to_complete']['from'],
                                orderData['date_to_complete']['to'])),
                      ],
                    ),
                    onTap: widget.onTap ??
                        () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderPage(
                                      orderID: orderData['order_id'].toString(),
                                      orderUID: orderData['uid'],
                                    )),
                          );
                        },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildOrderIconedInfo(orderData, IconData icon, String text) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: theme.bodySubtitleBold(text).translate(''),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
