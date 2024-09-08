import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_page_description.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_form_field.dart';
import 'package:b2clients/features/app/app_widgets/flutter_toast.dart';
import 'package:b2clients/features/auth/search_page.dart';
import 'package:b2clients/features/export.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class SetOrUpdateServiceTypesPage extends StatefulWidget {
  final String languageCode;
  const SetOrUpdateServiceTypesPage({
    required this.languageCode,
    super.key,
  });

  @override
  State<SetOrUpdateServiceTypesPage> createState() =>
      _SetOrUpdateServiceTypesPageState();
}

class _SetOrUpdateServiceTypesPageState
    extends State<SetOrUpdateServiceTypesPage> {
  final PageTheme theme = PageTheme();
  final AccountUtils accountUtils = AccountUtils();
  final FirebaseUtils firebaseUtils = FirebaseUtils();
  final SimpleUtils utils = SimpleUtils();
  final HomeUtils homeUtils = HomeUtils();
  final FlutterToast flutterToast = FlutterToast();
  final formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  List serviceTypesList = [];

  List userServiceTypesList = [];
  List serviceTypesListBools = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleTranslatorInit('AIzaSyB2qZLd7maHTp_VtAJvI5JQFuGSSDUIjmA',
        translateFrom: const Locale('en'),
        translateTo: Locale(widget.languageCode),
        builder: () => StreamBuilder(
            stream: homeUtils.getServicesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              Map<String, dynamic> pricesData = snapshot.data!;

              if (serviceTypesList.isEmpty) {
                Iterable<String> categories = pricesData.keys;
                serviceTypesList = categories.toList();
              }
              if (serviceTypesListBools.isEmpty) {
                serviceTypesListBools =
                    List.filled(serviceTypesList.length, false);
              }
              return Scaffold(
                backgroundColor: theme.pageColorGrey(),
                appBar: BuildAppBar(
                  title: 'What do you do?',
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SetNameAndSurnamePage(
                                languageCode: widget.languageCode)),
                      );
                    },
                  ),
                ),
                body: SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.normal),
                        child: StreamBuilder(
                            stream: accountUtils.getUserStream(),
                            builder: (context, snapshot) {
                              //error
                              if (snapshot.hasError) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              //loading
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              Map<String, dynamic> userData = snapshot.data!;
                              userServiceTypesList = userData['service_types'];
                              for (var service in userServiceTypesList) {
                                serviceTypesListBools[
                                    serviceTypesList.indexOf(service)] = true;
                              }
                              return Column(
                                children: [
                                  BuildPageDescription(
                                      text:
                                          'Enter all your specialities, so you can find more suitable orders.'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: BuildTextFormField(
                                        readOnly: true,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchPage(
                                                      languageCode:
                                                          widget.languageCode,
                                                      serviceTypesKeysList:
                                                          serviceTypesList,
                                                      userData: userData,
                                                    )),
                                          );
                                          // setState(() {});
                                        },
                                        icon: const Icon(Icons.search_rounded),
                                        obscureText: false,
                                        hintText: 'Service...',
                                        keyboardType: TextInputType.text,
                                        textEditingController:
                                            _searchController,
                                        formKey: formKey,
                                        validator: (value) {
                                          return null;
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 5,
                                      runSpacing: 2.5,
                                      children: List.generate(
                                        userServiceTypesList.length,
                                        (int index) {
                                          return ChoiceChip(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            showCheckmark: false,
                                            selectedColor: Colors.blue[50],
                                            disabledColor: Colors.white,
                                            backgroundColor: Colors.white,
                                            elevation: 2,
                                            label: Text(utils.toTitleCase(
                                                    userServiceTypesList[
                                                        index]))
                                                .translate(''),
                                            selected: serviceTypesListBools[
                                                serviceTypesList.indexOf(
                                                    userServiceTypesList[
                                                        index])],
                                            onSelected: (bool selected) {
                                              serviceTypesListBools[
                                                      serviceTypesList
                                                          .indexOf(
                                                              userServiceTypesList[
                                                                  index])] =
                                                  !serviceTypesListBools[
                                                      serviceTypesList.indexOf(
                                                          userServiceTypesList[
                                                              index])];

                                              userServiceTypesList.remove(
                                                  userServiceTypesList[index]);
                                              firebaseUtils.addServiceTypes(
                                                  userServiceTypesList);
                                            },
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                  userServiceTypesList.isEmpty
                                      ? const Center()
                                      : theme.elementDivider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Wrap(
                                      spacing: 5,
                                      runSpacing: 2.5,
                                      children: List.generate(
                                        serviceTypesList.length,
                                        (int index) {
                                          return ChoiceChip(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            showCheckmark: false,
                                            selectedColor: Colors.blue[50],
                                            disabledColor: Colors.white,
                                            backgroundColor: Colors.white,
                                            elevation: 2,
                                            label: Text(utils.toTitleCase(
                                                    serviceTypesList[index]))
                                                .translate(''),
                                            selected:
                                                serviceTypesListBools[index],
                                            onSelected: (bool selected) {
                                              serviceTypesListBools[index] =
                                                  !serviceTypesListBools[index];

                                              if (selected) {
                                                userServiceTypesList.add(
                                                    serviceTypesList[index]);
                                                firebaseUtils.addServiceTypes(
                                                    userServiceTypesList);
                                              } else {
                                                userServiceTypesList.remove(
                                                    serviceTypesList[index]);
                                                firebaseUtils.addServiceTypes(
                                                    userServiceTypesList);
                                              }
                                            },
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  )
                                ],
                              );
                            }),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BuildSingleButton(
                            title: 'Continue',
                            titleColor: Colors.white,
                            onPressed: () {
                              if (userServiceTypesList.isNotEmpty) {
                                firebaseUtils
                                    .addServiceTypes(userServiceTypesList);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DefinePricesCountPage(
                                            languageCode: widget.languageCode,
                                            pricesData: pricesData,
                                            accountDocumentID: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userServiceTypes:
                                                userServiceTypesList,
                                          )),
                                );
                              } else {
                                flutterToast.showToast(
                                    message:
                                        'To continue, you supposed to choose at least one of this service types.',
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
                  ),
                ),
              );
            }));
  }
}
