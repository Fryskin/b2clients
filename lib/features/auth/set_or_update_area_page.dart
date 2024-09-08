import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_button_form.dart';
import 'package:b2clients/features/app/app_widgets/build_page_description.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/flutter_toast.dart';
import 'package:b2clients/features/entrance/entrance_page.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class SetOrUpdateAreaPage extends StatefulWidget {
  final String languageCode;
  final String city;
  const SetOrUpdateAreaPage(
      {super.key, required this.city, required this.languageCode});

  @override
  State<SetOrUpdateAreaPage> createState() => _SetOrUpdateAreaPageState();
}

class _SetOrUpdateAreaPageState extends State<SetOrUpdateAreaPage> {
  PageTheme theme = PageTheme();
  SimpleUtils utils = SimpleUtils();
  FirebaseUtils firebaseUtils = FirebaseUtils();
  FlutterToast flutterToast = FlutterToast();

  List areasList = [];
  List isAreasCheckedList = [];
  List choosedAreasList = [];

  Future getAreas() async {
    if (areasList.isEmpty) {
      await FirebaseFirestore.instance
          .collection('cities')
          .doc('pE8XXLTCuDuC9DTonelY')
          .get()
          .then((snapshot) {
        Map<String, dynamic>? locationData = snapshot.data();
        areasList = locationData!['location']['cities'][widget.city]['areas'];
      });
    }

    if (isAreasCheckedList.isEmpty) {
      isAreasCheckedList = List.filled(areasList.length, false);
    }
  }

  Future addAcountInfo() async {
    for (int i = 0; i < areasList.length; i++) {
      if (isAreasCheckedList[i]) {
        choosedAreasList.add(areasList[i]);
      }
    }
    firebaseUtils.updateUserAccountData({
      'location': {
        'city': {
          widget.city: {
            'areas': choosedAreasList,
          },
        }
      }
    });
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
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    })),
            body: SafeArea(
                child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal),
                  child: Column(
                    children: [
                      BuildPageDescription(
                          text:
                              'Enter all the areas where do you provide your work, so your clients will find you faster.'),
                      FutureBuilder(
                          future: getAreas(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Wrap(
                                spacing: 0,
                                runSpacing: 10,
                                children: List.generate(
                                  areasList.length,
                                  (int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: BuildButtonForm(
                                          buttonColor: Colors.white,
                                          onPressed: () {
                                            isAreasCheckedList[index] =
                                                !isAreasCheckedList[index];

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
                                                    isAreasCheckedList[index],
                                                onChanged: (bool? value) {
                                                  isAreasCheckedList[index] =
                                                      value!;

                                                  setState(() {});
                                                },
                                              ),
                                              Flexible(
                                                child: theme
                                                    .bodySubtitle(
                                                        utils.toTitleCase(
                                                            areasList[index]))
                                                    .translate(''),
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                ).toList(),
                              ); //
                            } else if (areasList.isNotEmpty) {
                              return Wrap(
                                spacing: 0,
                                runSpacing: 10,
                                children: List.generate(
                                  areasList.length,
                                  (int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: BuildButtonForm(
                                          buttonColor: Colors.white,
                                          onPressed: () {
                                            isAreasCheckedList[index] =
                                                !isAreasCheckedList[index];

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
                                                    isAreasCheckedList[index],
                                                onChanged: (bool? value) {
                                                  isAreasCheckedList[index] =
                                                      value!;

                                                  setState(() {});
                                                },
                                              ),
                                              Flexible(
                                                child: theme
                                                    .bodySubtitle(
                                                        utils.toTitleCase(
                                                            areasList[index]))
                                                    .translate(''),
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                ).toList(),
                              ); //
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                      const SizedBox(
                        height: 150,
                      ),
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
                        if (isAreasCheckedList.contains(true)) {
                          addAcountInfo();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EntrancePage()),
                          );
                        } else {
                          flutterToast.showToast(
                              message:
                                  'To continue, you supposed to choose at least one of this areas.',
                              color: Colors.red);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ))));
  }
}
