// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_button_form.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/flutter_toast.dart';
import 'package:b2clients/services/simple_utils.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

import 'set_or_update_area_page.dart';

class SetOrUpdateCityPage extends StatefulWidget {
  final List pricesMapList;
  final String languageCode;
  const SetOrUpdateCityPage(
      {super.key, required this.pricesMapList, required this.languageCode});

  @override
  State<SetOrUpdateCityPage> createState() => _SetOrUpdateCityPageState();
}

class _SetOrUpdateCityPageState extends State<SetOrUpdateCityPage> {
  final PageTheme theme = PageTheme();
  final SimpleUtils utils = SimpleUtils();
  final FlutterToast flutterToast = FlutterToast();

  List citiesList = [];
  List isCitiesCheckedList = [];

  Future getCities() async {
    if (citiesList.isEmpty) {
      await FirebaseFirestore.instance
          .collection('cities')
          .doc('pE8XXLTCuDuC9DTonelY')
          .get()
          .then((snapshot) {
        Map<String, dynamic>? locationData = snapshot.data();
        citiesList = locationData!['location']['cities'].keys.toList();
      });
    }

    if (isCitiesCheckedList.isEmpty) {
      isCitiesCheckedList = List.filled(citiesList.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleTranslatorInit('AIzaSyB2qZLd7maHTp_VtAJvI5JQFuGSSDUIjmA',
        translateFrom: const Locale('en'),
        translateTo: Locale(widget.languageCode),
        builder: () => Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: theme.pageColorGrey(),
            appBar: BuildAppBar(
              title: 'Where do you work?',
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  if (widget.pricesMapList.isNotEmpty) {
                    widget.pricesMapList.removeLast();
                  }
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
                child: Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 20),
                        child: theme
                            .defaultTextCenter(
                                'Enter the city where do you provide your work, so your clients will find you faster.')
                            .translate(''),
                      ),
                      FutureBuilder(
                          future: getCities(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Wrap(
                                spacing: 0,
                                runSpacing: 10,
                                children: List.generate(
                                  citiesList.length,
                                  (int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: BuildButtonForm(
                                          buttonColor: Colors.white,
                                          onPressed: () {
                                            isCitiesCheckedList[index] =
                                                !isCitiesCheckedList[index];

                                            setState(() {});
                                          },
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                checkColor: Colors.white,
                                                activeColor: Colors.black,
                                                value:
                                                    isCitiesCheckedList[index],
                                                onChanged: (bool? value) {
                                                  isCitiesCheckedList[index] =
                                                      value!;

                                                  setState(() {});
                                                },
                                              ),
                                              Flexible(
                                                child: theme
                                                    .bodySubtitle(
                                                        utils.toTitleCase(
                                                            citiesList[index]))
                                                    .translate(''),
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                ).toList(),
                              );
                            } else if (citiesList.isNotEmpty) {
                              return Wrap(
                                spacing: 0,
                                runSpacing: 10,
                                children: List.generate(
                                  citiesList.length,
                                  (int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: BuildButtonForm(
                                          buttonColor: Colors.white,
                                          onPressed: () {
                                            isCitiesCheckedList[index] =
                                                !isCitiesCheckedList[index];

                                            setState(() {});
                                          },
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                checkColor: Colors.white,
                                                activeColor: Colors.black,
                                                value:
                                                    isCitiesCheckedList[index],
                                                onChanged: (bool? value) {
                                                  isCitiesCheckedList[index] =
                                                      value!;

                                                  setState(() {});
                                                },
                                              ),
                                              Flexible(
                                                child: theme
                                                    .bodySubtitle(
                                                        utils.toTitleCase(
                                                            citiesList[index]))
                                                    .translate(''),
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                ).toList(),
                              ); //
                            }
                            return Center(child: CircularProgressIndicator());
                          }),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BuildSingleButton(
                        title: 'Continue',
                        titleColor: Colors.white,
                        onPressed: () {
                          if (isCitiesCheckedList.contains(true)) {
                            // addAcountInfo();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SetOrUpdateAreaPage(
                                      languageCode: widget.languageCode,
                                      city: citiesList[
                                          isCitiesCheckedList.indexOf(true)])),
                            );
                          } else {
                            flutterToast.showToast(
                                message:
                                    'To continue, you supposed to choose the city.',
                                color: Colors.red);
                          }
                        }),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ))));
  }
}
