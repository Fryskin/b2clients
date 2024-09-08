import 'package:b2clients/features/app/app_widgets/build_button_form.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildTileDescription extends StatelessWidget {
  final String title;
  final String subtitle;
  BuildTileDescription(
      {super.key, required this.title, required this.subtitle});

  final PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BuildButtonForm(
        buttonColor: Colors.white,
        onPressed: () {},
        child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: theme.defaultText(title).translate(''),
            subtitle: theme.bodyTitle(subtitle).translate('')),
      ),
    );
  }
}
