import 'package:b2clients/features/app/app_widgets/build_button_form.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildLinkButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final String auxiliaryText;
  BuildLinkButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.auxiliaryText});

  final PageTheme theme = PageTheme();

  @override
  Widget build(BuildContext context) {
    return BuildButtonForm(
        buttonColor: theme.cardColorWhite(),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            theme.bodyTitleSettings(title).translate(''),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: theme.defaultText(auxiliaryText).translate(''),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ));
  }
}
