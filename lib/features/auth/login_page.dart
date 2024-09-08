import 'package:b2clients/features/app/app_utils/validators.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_form_field.dart';
import 'package:b2clients/features/auth/auth_utils.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  final VoidCallback showUpdatePasswordPage;
  // final VoidCallback showUpdatePasswordPage;
  const LoginPage({
    super.key,
    required this.showRegisterPage,
    required this.showUpdatePasswordPage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthUtils authUtils = AuthUtils();
  PageTheme theme = PageTheme();
  Validators validators = Validators();
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 245, 177),
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
                  child: BuildTextButton(
                    onPressed: widget.showUpdatePasswordPage,
                    title: 'I fogot my password',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                        return value!.isEmpty ? 'This field is empty' : null;
                      }),
                ),
                const SizedBox(
                  height: 40,
                ),
                BuildSingleButton(
                    title: 'Sign in',
                    titleColor: Colors.white,
                    onPressed: () {
                      if (emailFormKey.currentState!.validate() &&
                          passwordFormKey.currentState!.validate()) {
                        authUtils
                            .signIn(_emailController, _passwordController)
                            .then((value) {
                          if (value) {
                            // setState(() {});
                          }
                        });
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    theme.defaultText("Not a user yet?").translate(''),
                    BuildTextButton(
                      onPressed: widget.showRegisterPage,
                      title: "Register now!",
                    )
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

  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
}
