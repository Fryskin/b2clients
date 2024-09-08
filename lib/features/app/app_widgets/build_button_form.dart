import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class BuildButtonForm extends StatelessWidget {
  final Color? buttonColor;
  final void Function()? onPressed;
  final Widget? child;
  BuildButtonForm({
    super.key,
    required this.buttonColor,
    required this.onPressed,
    required this.child,
  });
  final PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 10),
        ),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        backgroundColor: WidgetStatePropertyAll(buttonColor),
        shadowColor: WidgetStatePropertyAll(buttonColor),
        surfaceTintColor: WidgetStatePropertyAll(buttonColor),
        elevation: const WidgetStatePropertyAll(0),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
