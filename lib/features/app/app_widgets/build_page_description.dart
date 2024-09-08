import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildPageDescription extends StatelessWidget {
  final String text;
  BuildPageDescription({super.key, required this.text});

  final PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 20),
      child: theme.defaultTextCenter(text).translate(''),
    );
  }
}
