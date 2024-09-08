import 'package:b2clients/features/app/app_widgets/build_button_form.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildLinkIconedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final String auxiliaryText;
  final Icon icon;
  BuildLinkIconedButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
    required this.auxiliaryText,
  });

  final PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return BuildButtonForm(
      buttonColor: theme.cardColorWhite(),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: theme.bodyTitleSettings(title).translate(''),
              ),
            ],
          ),
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
      ),
    );
  }
}
