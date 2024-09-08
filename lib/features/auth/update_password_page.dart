// ignore_for_file: use_build_context_synchronously

import 'package:b2clients/features/app/app_utils/validators.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_form_field.dart';
import 'package:b2clients/features/auth/auth_utils.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatefulWidget {
  // final VoidCallback showLoginPage;
  final VoidCallback showLoginPage2;

  const UpdatePasswordPage({super.key, required this.showLoginPage2});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final PageTheme theme = PageTheme();
  final AuthUtils authUtils = AuthUtils();
  final Validators validators = Validators();
  final _emailController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 240, 221),
      body: SafeArea(
        child: Stack(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                      obscureText: false,
                      hintText: 'Example@email.com',
                      keyboardType: TextInputType.text,
                      textEditingController: _emailController,
                      formKey: _emailFormKey,
                      validator: (value) {
                        return validators.validateEmail(value);
                      }),
                ),
                const SizedBox(height: 40),
                BuildSingleButton(
                    title: 'Send a mail',
                    titleColor: Colors.white,
                    onPressed: () {
                      if (_emailFormKey.currentState!.validate()) {
                        authUtils.resetPassword(_emailController, context);
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildTextButton(
                        onPressed: widget.showLoginPage2,
                        title: "I changed my mind"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
