import 'package:b2clients/features/app/app_widgets/build_button_form.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildTileInfo extends StatelessWidget {
  final String textRight;
  final String textLeft;
  BuildTileInfo({super.key, required this.textRight, required this.textLeft});
  final PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return BuildButtonForm(
      buttonColor: Colors.white,
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          theme.bodyTitleSettings(textRight).translate(''),
          theme.defaultText(textLeft)
        ],
      ),
    );
  }
}
