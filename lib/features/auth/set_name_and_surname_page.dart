// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_const_constructors

import 'package:b2clients/features/app/account/change_language_page.dart';
import 'package:b2clients/features/app/app_utils/validators.dart';
import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_button_form.dart';
import 'package:b2clients/features/app/app_widgets/build_page_description.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_form_field.dart';
import 'package:b2clients/features/app/app_widgets/flutter_toast.dart';
import 'package:b2clients/features/auth/auth_utils.dart';

import 'package:b2clients/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

import 'set_or_update_servise_types_page.dart';

class SetNameAndSurnamePage extends StatefulWidget {
  final String languageCode;
  // final String userID;
  const SetNameAndSurnamePage({
    super.key,
    required this.languageCode,
    //  required this.userID
  });

  @override
  State<SetNameAndSurnamePage> createState() => _SetNameAndSurnamePageState();
}

class _SetNameAndSurnamePageState extends State<SetNameAndSurnamePage> {
  PageTheme theme = PageTheme();
  AuthUtils authUtils = AuthUtils();
  FlutterToast flutterToast = FlutterToast();
  Validators validators = Validators();
  final nameFormKey = GlobalKey<FormState>();
  final surnameFormKey = GlobalKey<FormState>();

  bool isChecked = false;
  bool isUserAgree = false;

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleTranslatorInit(
      'AIzaSyB2qZLd7maHTp_VtAJvI5JQFuGSSDUIjmA',
      translateFrom: Locale('en'),
      translateTo: Locale(widget.languageCode),
      builder: () => Scaffold(
        backgroundColor: theme.pageColorGrey(),
        appBar: BuildAppBar(
          title: 'What is your name?',
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeLanguagePage(
                          languageCode: widget.languageCode,
                          iterationType: 'set',
                        )),
              );
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  BuildPageDescription(
                      text:
                          'Please, enter your full name as in your documents, this is very important for verification.'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: BuildTextFormField(
                        obscureText: false,
                        hintText: 'Name',
                        keyboardType: TextInputType.text,
                        textEditingController: _nameController,
                        formKey: nameFormKey,
                        validator: (value) {
                          return validators.validateUpperAndLowerCase(value);
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: BuildTextFormField(
                        obscureText: false,
                        hintText: 'Surname',
                        keyboardType: TextInputType.text,
                        textEditingController: _surnameController,
                        formKey: surnameFormKey,
                        validator: (value) {
                          return validators.validateUpperAndLowerCase(value);
                        }),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BuildButtonForm(
                    buttonColor: theme.pageColorGrey(),
                    onPressed: () {
                      isChecked = !isChecked;

                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          checkColor: Colors.white,
                          activeColor: Colors.black,
                          value: isChecked,
                          onChanged: (bool? value) {
                            isUserAgree = !isUserAgree;

                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Flexible(
                          child: theme
                              .bodySubtitle(
                                  'I accept the public offer, terms of use, privacy policy.')
                              .translate(''),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BuildSingleButton(
                    title: 'Continue',
                    titleColor: Colors.white,
                    onPressed: () {
                      if (!isChecked) {
                        flutterToast.showToast(
                            message:
                                'To continue, you must accept the terms of use.',
                            color: Colors.red);
                      }
                      if (isChecked &&
                          nameFormKey.currentState!.validate() &&
                          surnameFormKey.currentState!.validate()) {
                        authUtils.addAdditionalAccountData(
                            _nameController, _surnameController);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetOrUpdateServiceTypesPage(
                                  languageCode: widget.languageCode)),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
