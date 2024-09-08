import 'package:b2clients/features/app/app_widgets/build_pinput.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/flutter_toast.dart';
import 'package:b2clients/features/export.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildAlertDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey1;
  final TextEditingController optController;
  BuildAlertDialog(
      {super.key, required this.formKey1, required this.optController});

  final PageTheme theme = PageTheme();
  final AccountUtils accountUtils = AccountUtils();
  final FlutterToast flutterToast = FlutterToast();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: theme.pageColor(),
        title: Center(
          child: theme.userNameTitle('Enter code').translate(''),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                key: formKey1,
                child: BuildPinput(optController: optController)),
          ],
        ),
        actions: [
          BuildSingleButton(
            title: 'Confirm',
            titleColor: Colors.white,
            onPressed: () async {
              if (formKey1.currentState!.validate()) {
                AuthService.updatePhoneNumber(opt: optController.text)
                    .then((value) {
                  if (value == 'Success') {
                    accountUtils.updatePhoneNumber();
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangeUserInfoPage()));
                  } else {
                    Navigator.pop(context);
                    flutterToast.showToast(message: value, color: Colors.red);
                  }
                });
              }
            },
          ),
        ]);
  }
}
