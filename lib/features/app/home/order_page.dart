// ignore_for_file: prefer_const_constructors

import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_button_container.dart';
import 'package:b2clients/features/app/app_widgets/build_tile_description.dart';
import 'package:b2clients/features/app/app_widgets/build_tile_info.dart';
import 'package:b2clients/features/app/export.dart';

import 'package:b2clients/features/export.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class OrderPage extends StatefulWidget {
  final String orderUID;
  final String orderID;

  const OrderPage({
    super.key,
    required this.orderUID,
    required this.orderID,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final SimpleUtils simpleUtils = SimpleUtils();
  final FirebaseUtils fireBaseutils = FirebaseUtils();
  final PageTheme theme = PageTheme();
  final HomeUtils homeUtils = HomeUtils();

  dynamic getWishes(String orderWishes) {
    if (orderWishes.toString().isEmpty) {
      return Column();
    } else {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          BuildTileDescription(title: 'Wishes', subtitle: orderWishes),
        ],
      );
    }
  }

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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic>? orderData = snapshot.data!;
          return Scaffold(
              backgroundColor: theme.pageColorGrey(),
              appBar: BuildAppBar(
                title: simpleUtils.toTitleCase(orderData['service_type']),
                goBack: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                scrollDirection: Axis.vertical,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              StreamBuilder(
                                  stream: homeUtils.getPagesContentStream(),
                                  builder: (context, snapshot) {
                                    //error
                                    if (snapshot.hasError) {
                                      return const Text('error');
                                    }
                                    //loading
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    Map pagesContentData = snapshot.data![
                                        orderData['service_type']
                                            .toString()
                                            .trim()]['pages_content'];

                                    return ListView.builder(
                                      physics: BouncingScrollPhysics(
                                          decelerationRate:
                                              ScrollDecelerationRate.normal),
                                      shrinkWrap: true,
                                      itemCount: pagesContentData.length,
                                      itemBuilder: (context, index) =>
                                          Column(children: [
                                        BuildOrderListTile(
                                          descriptionTitle:
                                              pagesContentData['$index'][0],
                                          descriptionInfo: orderData[
                                              pagesContentData['$index'][0]],
                                        ),
                                      ]),
                                    );
                                  }),
                              BuildTileDescription(
                                  title: 'Favorible date',
                                  subtitle: homeUtils
                                      .getOrderDateToCompleteFromAndToString(
                                          orderData['date_to_complete']['from'],
                                          orderData['date_to_complete']['to'])),
                              SizedBox(
                                height: 10,
                              ),
                              BuildTileDescription(
                                  title: 'Address',
                                  subtitle: homeUtils.getOrderAddressString(
                                      orderData['location']['city']['prague']
                                          ['areas'])),
                              SizedBox(
                                height: 10,
                              ),
                              BuildTileDescription(
                                  title: 'Suitable price',
                                  subtitle: homeUtils.getOrderPriceString(
                                      orderData['price']['from'],
                                      orderData['price']['to'],
                                      orderData['price']['symbol'])),
                              getWishes(orderData['wishes']),
                              SizedBox(
                                height: 20,
                              ),
                              Card(
                                shape: theme.cardShapeBorderOnly(),
                                shadowColor: theme.cardColorWhite(),
                                surfaceTintColor: theme.cardColorWhite(),
                                elevation: 0,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                color: theme.cardColorWhite(),
                                child: ListTile(
                                    leading: Icon(
                                      Icons.account_circle_rounded,
                                      size: 40,
                                    ),
                                    title: theme.bodyTitleSettings(
                                        orderData['order_holder_name']),
                                    subtitle: theme
                                        .defaultText(
                                            'since ${homeUtils.monthsList[homeUtils.userRegisterMonth - 2]} ${homeUtils.userRegisterYear}')
                                        .translate('')),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              BuildButtonContainer(children: [
                                BuildTileInfo(
                                    textRight: "Order's ID",
                                    textLeft: orderData['order_id'].toString()),
                                theme.dividerTextFieldSettings(),
                                BuildTileInfo(
                                  textRight: 'Creation date',
                                  textLeft: homeUtils.getOrderDateCreatedString(
                                      orderData['time_created']),
                                ),
                                theme.dividerTextFieldSettings(),
                                BuildTileInfo(
                                  textRight: 'Update date',
                                  textLeft: homeUtils.getOrderDateUpdatedString(
                                      orderData['time_updated']),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              StreamBuilder(
                                  stream: homeUtils
                                      .getClientStream(orderData['uid']),
                                  builder: (context, snapshot) {
                                    //error
                                    if (snapshot.hasError) {
                                      return const Text('error');
                                    }
                                    //loading
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    Map<String, dynamic>? clientData =
                                        snapshot.data!;

                                    return RespondButtonWidget(
                                      clientLanguageCode:
                                          clientData['language_code'],
                                      clientEmail: clientData['email'],
                                      clientName: clientData['name'],
                                      clientSurname: clientData['surname'],
                                      onTap: () {
                                        setState(() {});
                                      },
                                      orderFeedbacksList:
                                          orderData['feedbacks'],
                                      orderConfirmedFeedbacksList:
                                          orderData['confirmed_feedbacks'],
                                      orderDocumentID:
                                          '${orderData['uid']}-${orderData['order_id']}',
                                      orderID: orderData['order_id'].toString(),
                                      orderServiceType:
                                          orderData['service_type'],
                                      orderHolderName:
                                          orderData['order_holder_name'],
                                      orderUID: orderData['uid'],
                                    );
                                  }),
                              SizedBox(
                                height: 20,
                              )
                            ]),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
