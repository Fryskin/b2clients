import 'package:b2clients/features/app/app_utils/validators.dart';
import 'package:b2clients/features/app/app_widgets/build_alert_dialog.dart';
import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/build_button_container.dart';
import 'package:b2clients/features/app/app_widgets/build_text_form_field.dart';
import 'package:b2clients/features/app/app_widgets/flutter_toast.dart';

import 'package:b2clients/services/export.dart';

import 'package:b2clients/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class ChangePhoneNumberPage extends StatefulWidget {
  const ChangePhoneNumberPage({super.key});

  @override
  State<ChangePhoneNumberPage> createState() => _ChangePhoneNumberPageState();
}

class _ChangePhoneNumberPageState extends State<ChangePhoneNumberPage> {
  PageTheme theme = PageTheme();
  FlutterToast flutterToast = FlutterToast();
  final Validators validators = Validators();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _optController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _optController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.pastelYellow(),
      appBar: BuildAppBar(
        removeElevation: true,
        backgroundColor: theme.pastelYellow(),
        title: 'Change phone number',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.phone_iphone_outlined,
                    size: 140,
                  ),
                  theme.userNameTitle('New phone number').translate(''),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 65),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        theme
                            .defaultTextCenter(
                                'We will send a confirmation code to your new phone number whitch you enter below.')
                            .translate(''),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BuildButtonContainer(children: [
                    BuildTextFormField(
                        obscureText: false,
                        hintText: '+420000000000',
                        keyboardType: TextInputType.phone,
                        textEditingController: _phoneNumberController,
                        formKey: _formKey,
                        validator: (value) {
                          return validators.validatePhoneNumber(value);
                        }),
                  ])
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BuildSingleButton(
                  title: 'Send verify pin',
                  titleColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthService.sendOTP(
                          phoneNumber: _phoneNumberController.text,
                          errorStep: () => flutterToast.showToast(
                              message: 'Error on sending otp',
                              color: Colors.red),
                          nextStep: () {
                            showDialog(
                                context: context,
                                builder: (context) => BuildAlertDialog(
                                    formKey1: _formKey1,
                                    optController: _optController));
                          });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
