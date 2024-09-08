import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildTextButton extends StatelessWidget {
  final String title;
  final bool? addArrow;
  final void Function()? onPressed;
  BuildTextButton(
      {super.key, this.addArrow, required this.onPressed, required this.title});
  final PageTheme theme = PageTheme();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 0))),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          theme.bodyTitleCenter(title).translate(''),
          addArrow != null && addArrow != false
              ? const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                )
              : const Text('')
        ],
      ),
    );
  }
}
