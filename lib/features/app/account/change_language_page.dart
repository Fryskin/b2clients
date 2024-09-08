import 'package:b2clients/business_to_clients_app.dart';
import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_button_container.dart';
import 'package:b2clients/features/app/app_widgets/build_link_button.dart';
import 'package:b2clients/features/app/app_widgets/build_page_description.dart';
import 'package:b2clients/features/export.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class ChangeLanguagePage extends StatefulWidget {
  final String languageCode;
  final String iterationType;
  const ChangeLanguagePage(
      {super.key, required this.iterationType, required this.languageCode});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  final FirebaseUtils firebaseUtils = FirebaseUtils();
  final AccountUtils accountUtils = AccountUtils();
  final PageTheme theme = PageTheme();

  @override
  Widget build(BuildContext context) {
    return GoogleTranslatorInit(
      'AIzaSyB2qZLd7maHTp_VtAJvI5JQFuGSSDUIjmA',
      translateFrom: const Locale('en'),
      translateTo: Locale(widget.languageCode),
      builder: () => Scaffold(
        backgroundColor: theme.pageColor(),
        appBar: BuildAppBar(
          title: 'Language',
          leading: Row(
            children: [
              widget.iterationType == 'update'
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BusinessToClientsApp(
                                  languageCode: widget.languageCode)),
                        );
                      },
                    )
                  : const Center()
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.normal,
          ),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              BuildPageDescription(
                  text:
                      'On this page you can change the language of the application.'),
              ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: accountUtils.languages.entries.length,
                itemBuilder: (context, index) =>
                    BuildButtonContainer(children: [
                  BuildLinkButton(
                      onPressed: () {
                        accountUtils.changeLanguage(accountUtils
                            .languages.entries
                            .elementAt(index)
                            .key);

                        widget.iterationType == 'update'
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BusinessToClientsApp(
                                          languageCode: accountUtils
                                              .languages.entries
                                              .elementAt(index)
                                              .key,
                                        )),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SetNameAndSurnamePage(
                                          languageCode: accountUtils
                                              .languages.entries
                                              .elementAt(index)
                                              .key,
                                        )),
                              );
                      },
                      title:
                          accountUtils.languages.entries.elementAt(index).value,
                      auxiliaryText: accountUtils.translatedLanguages[index]),
                  index == accountUtils.languages.entries.length - 1
                      ? const Center()
                      : theme.dividerTextFieldSettings()
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
