import 'package:b2clients/features/app/app_widgets/build_button_form.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildSingleButton extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final void Function()? onPressed;
  BuildSingleButton({
    super.key,
    required this.title,
    required this.titleColor,
    required this.onPressed,
  });
  final PageTheme theme = PageTheme();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BuildButtonForm(
            buttonColor: theme.cardColorBlack(),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: titleColor,
                      fontSize: 17,
                      letterSpacing: 0.3),
                ).translate(''),
              ],
            ),
          ),
        ));
  }
}
