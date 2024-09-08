import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_button_container.dart';
import 'package:b2clients/features/app/app_widgets/build_page_description.dart';
import 'package:b2clients/features/app/app_widgets/build_text_form_field.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:translator_plus/translator_plus.dart';

import '../export.dart';

class SearchPage extends StatefulWidget {
  final String languageCode;
  final List serviceTypesKeysList;
  final Map<String, dynamic> userData;
  const SearchPage(
      {super.key,
      required this.languageCode,
      required this.serviceTypesKeysList,
      required this.userData});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // TranslateService translateService = TranslateService();
  PageTheme theme = PageTheme();
  SimpleUtils simpleUtils = SimpleUtils();
  FirebaseUtils firebaseUtils = FirebaseUtils();

  final TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List translatedServices = [];
  List items = [];

  void queryListener() {
    setState(() {
      search(searchController.text);
    });
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        items = translatedServices;
      });
    } else {
      setState(() {
        items = translatedServices
            .where((service) => service
                .toString()
                .toLowerCase()
                .replaceAll('_', ' ')
                .contains(query.toLowerCase()))
            .toList();
        items.add(query);
      });
    }
  }

  Future translateServices(services) async {
    Map userData = await firebaseUtils.getAccountData();
    for (String service in services) {
      await simpleUtils
          .toTitleCase(service)
          .translate(to: userData['language_code'])
          .then((service) => translatedServices.add(service.text));
    }
  }

  Future addServiceTypes(serviceType) async {
    List userServiceTypesList = widget.userData['service_types'];
    userServiceTypesList.contains(serviceType)
        ? userServiceTypesList.remove(serviceType)
        : userServiceTypesList.add(serviceType);
    firebaseUtils
        .updateUserAccountData({'service_types': userServiceTypesList});
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    translateServices(widget.serviceTypesKeysList);
    searchController.addListener(queryListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.pageColorGrey(),
        appBar: BuildAppBar(
          title: 'What do you do?',
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.normal),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildPageDescription(
                    text:
                        'Enter all your specialities, so you can find more suitable orders.'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    // color: theme.pageColor(),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: BuildTextFormField(
                              autofocus: true,
                              icon: const Icon(Icons.search_rounded),
                              obscureText: false,
                              hintText: 'Service...',
                              keyboardType: TextInputType.text,
                              textEditingController: searchController,
                              formKey: formKey,
                              validator: (value) {
                                return null;
                              }),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SetOrUpdateServiceTypesPage(
                                        languageCode: 'en',
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: theme.cardShapeBorderCenter(),
                  color: theme.appBarColor(),
                  shadowColor: theme.appBarColor(),
                  surfaceTintColor: theme.appBarColor(),
                  elevation: 0,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: BuildButtonContainer(
                    children: [
                      ListView.builder(
                          addAutomaticKeepAlives: false,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 45,
                                  child: ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          theme.bodyTitleSettings(simpleUtils
                                              .toTitleCase(items[index])),
                                          const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                      subtitle: const Text(''),
                                      onTap: () {
                                        addServiceTypes(
                                            widget.serviceTypesKeysList[
                                                translatedServices
                                                    .indexOf(items[index])]);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SetOrUpdateServiceTypesPage(
                                                    languageCode:
                                                        widget.languageCode,
                                                  )),
                                        );
                                      }),
                                ),
                                theme.divider()
                              ],
                            );
                          }),
                    ],
                  ),
                )
              ],
            )));
  }
}
