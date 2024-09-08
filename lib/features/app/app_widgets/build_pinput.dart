import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class BuildPinput extends StatelessWidget {
  final TextEditingController? optController;
  BuildPinput({super.key, required this.optController});
  final PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      keyboardType: TextInputType.number,
      controller: optController,
      validator: (value) {
        if (value!.length != 6) {
          return "Invalid OPT";
        }
        return null;
      },
      defaultPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: TextStyle(
            fontSize: 20,
            color: theme.cardColorBlack(),
            fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
          color: theme.pageColorGrey(),
          border: Border.all(color: theme.cardColorBlack()),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: TextStyle(
            fontSize: 20,
            color: theme.cardColorBlack(),
            fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
          color: theme.pageColorGrey(),
          border: Border.all(color: theme.cardColorBlack()),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: TextStyle(
            fontSize: 20,
            color: theme.cardColorBlack(),
            fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
          color: theme.pageColorGrey(),
          border: Border.all(color: theme.pageColorGrey()),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
