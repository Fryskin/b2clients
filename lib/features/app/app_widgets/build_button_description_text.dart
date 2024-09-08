import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildButtonDescriptionText extends StatelessWidget {
  final String text;
  BuildButtonDescriptionText({super.key, required this.text});

  final PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
      child: theme.defaultText(text).translate(''),
    );
  }
}
