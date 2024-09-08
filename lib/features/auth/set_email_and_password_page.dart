import 'package:b2clients/features/app/app_utils/validators.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_form_field.dart';
import 'package:b2clients/features/app/app_widgets/flutter_toast.dart';
import 'package:b2clients/features/auth/auth_utils.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class SetEmailAndPasswordPage extends StatefulWidget {
  const SetEmailAndPasswordPage({super.key, required this.showLoginPage});

  final VoidCallback showLoginPage;

  @override
  State<SetEmailAndPasswordPage> createState() =>
      _SetEmailAndPasswordPageState();
}

class _SetEmailAndPasswordPageState extends State<SetEmailAndPasswordPage> {
  AuthUtils authUtils = AuthUtils();
  FlutterToast flutterToast = FlutterToast();
  PageTheme theme = PageTheme();
  Validators validators = Validators();

  final passwordFormKey = GlobalKey<FormState>();
  final confimPasswordFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 194, 225, 255),
      body: SafeArea(
        child: Stack(
          children: [
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
                      formKey: emailFormKey,
                      validator: (value) {
                        return validators.validateEmail(value);
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                      obscureText: true,
                      hintText: 'Password',
                      keyboardType: TextInputType.text,
                      textEditingController: _passwordController,
                      formKey: passwordFormKey,
                      validator: (value) {
                        return validators.validatePassword(value);
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                      obscureText: true,
                      hintText: 'Confirm password',
                      keyboardType: TextInputType.text,
                      textEditingController: _confirmPasswordController,
                      formKey: confimPasswordFormKey,
                      validator: (value) {
                        return _passwordController.text !=
                                _confirmPasswordController.text
                            ? 'Passwords do not match.'
                            : null;
                      }),
                ),
                const SizedBox(
                  height: 40,
                ),
                BuildSingleButton(
                  title: 'Register',
                  titleColor: Colors.white,
                  onPressed: () async {
                    if (emailFormKey.currentState!.validate() &&
                        passwordFormKey.currentState!.validate() &&
                        confimPasswordFormKey.currentState!.validate()) {
                      authUtils
                          .signUp(_emailController, _passwordController,
                              _confirmPasswordController)
                          .then((value) {
                        if (value) {
                          // setState(() {});
                        }
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    theme.defaultText("Already a user?").translate(''),
                    BuildTextButton(
                        onPressed: widget.showLoginPage, title: "Login")
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
