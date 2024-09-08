import 'package:b2clients/features/app/app_widgets/build_button_form.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  final dynamic autofocus;
  final dynamic readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? icon;
  final TextEditingController textEditingController;
  final GlobalKey<FormState> formKey;

  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool obscureText;
  BuildTextFormField(
      {super.key,
      this.readOnly,
      this.autofocus,
      this.onTap,
      this.onChanged,
      this.icon,
      required this.obscureText,
      required this.hintText,
      required this.keyboardType,
      required this.textEditingController,
      required this.formKey,
      required this.validator});

  final PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return BuildButtonForm(
        buttonColor: theme.cardColorWhite(),
        onPressed: () {},
        child: Form(
          key: formKey,
          child: TextFormField(
            readOnly: readOnly ?? false,
            autofocus: autofocus ?? false,
            onTap: onTap,
            onChanged: onChanged,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: Colors.grey[800],
            cursorErrorColor: Colors.grey[800],
            controller: textEditingController,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: icon,
              hintText: hintText,
              focusedErrorBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            validator: validator,
          ),
        ));
  }
}
