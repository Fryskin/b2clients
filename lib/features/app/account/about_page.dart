import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  final dynamic workerDocumentID;
  const AboutPage({super.key, required this.workerDocumentID});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  PageTheme theme = PageTheme();
  FirebaseUtils utils = FirebaseUtils();
  final _aboutController = TextEditingController();

  @override
  void dispose() {
    _aboutController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  dynamic workerAbout;

  Future getAccountData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    dynamic accountData;
    await FirebaseFirestore.instance
        .collection('accounts')
        .where('uid', isEqualTo: uid)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              accountData = document.data();
              workerAbout = accountData['about'];
            }));
    _aboutController.text = workerAbout;
  }

  Future addAbout() async {
    await FirebaseFirestore.instance
        .collection('accounts')
        .doc(widget.workerDocumentID)
        .update({'about': _aboutController.text});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAccountData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: theme.pageColorGrey(),
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                elevation: 1,
                title: theme.appBarTitle('About'),
                // foregroundColor: theme.appBarColor(),
                shadowColor: theme.appBarColor(),
                backgroundColor: theme.appBarColor(),
                surfaceTintColor: theme.appBarColor(),
                automaticallyImplyLeading: false,
                centerTitle: true,
                scrolledUnderElevation: theme.elevationAppBarScrolledUnder(),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.normal),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            title: theme.bodyTitle('Tell about yourself'),
                            subtitle: theme.bodySubtitle(
                                'This info wiil help clients to understand your speciality better.'),
                          ),
                          Card(
                            shape: theme.cardShapeBorderOnly(),
                            shadowColor: theme.cardColorWhite(),
                            surfaceTintColor: theme.cardColorWhite(),
                            elevation: 0,
                            margin: EdgeInsets.only(
                                top: 0, bottom: 0, left: 10, right: 10),
                            color: theme.cardColorWhite(),
                            child: TextField(
                              // expands: true,
                              maxLength: 500,
                              maxLines: 10,
                              minLines: 1,
                              controller: _aboutController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.emoji_objects_outlined),

                                filled: true,
                                fillColor: theme.cardColorWhite(),
                                // focusColor: Color.fromARGB(255, 173, 182, 187),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.cardColorWhite(),
                                        width: 0),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: theme.cardColorWhite(),
                                        width: 0),
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'Write about yourself...',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 45,
                          child: Card(
                            shape: theme.cardShapeBorderOnly(),
                            shadowColor: theme.cardColorBlack(),
                            surfaceTintColor: theme.cardColorBlack(),
                            elevation: 0,
                            margin: EdgeInsets.only(
                                top: 0, bottom: 0, left: 10, right: 10),
                            color: theme.cardColorBlack(),
                            child: ListTile(
                              onTap: () {
                                if (_aboutController.text.trim().isNotEmpty) {
                                  addAbout();
                                  Navigator.pop(context);
                                }
                              },
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.content_paste,
                                        size: 28,
                                        color: const Color.fromARGB(0, 0, 0, 0),
                                      ),
                                      theme.bodyTitleSettingsWhite('Confirm'),
                                      Icon(
                                        Icons.content_paste,
                                        size: 28,
                                        color: const Color.fromARGB(0, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Center(child: Text('')),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Center();
        });
  }
}
