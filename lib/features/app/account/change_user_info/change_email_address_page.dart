import 'package:b2clients/features/app/app_utils/validators.dart';
import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/build_button_container.dart';
import 'package:b2clients/features/app/app_widgets/build_button_description_text.dart';
import 'package:b2clients/features/app/app_widgets/build_text_form_field.dart';
import 'package:b2clients/features/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class ChangeEmailAddressPage extends StatefulWidget {
  const ChangeEmailAddressPage({super.key});

  @override
  State<ChangeEmailAddressPage> createState() => _ChangeEmailAddressPageState();
}

class _ChangeEmailAddressPageState extends State<ChangeEmailAddressPage> {
  PageTheme theme = PageTheme();
  Validators validators = Validators();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKeyEmail = GlobalKey<FormState>();
  final formKeyPassword = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future resetEmail() async {
    User user = FirebaseAuth.instance.currentUser!;

    var credential = EmailAuthProvider.credential(
        email: user.email.toString(), password: _passwordController.text);
    var result = await user.reauthenticateWithCredential(credential);
    await result.user?.verifyBeforeUpdateEmail(_emailController.text);
    await FirebaseAuth.instance.signOut();
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EntrancePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.pastelGreen(),
      appBar: BuildAppBar(
        backgroundColor: theme.pastelGreen(),
        removeElevation: true,
        title: 'Change email address',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.email_outlined,
                    size: 140,
                  ),
                  theme.userNameTitle('New email address').translate(''),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 65),
                    child: theme
                        .defaultTextCenter(
                            'We will send a confirmation link to your new email address whitch you enter below.')
                        .translate(''),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BuildButtonContainer(children: [
                    BuildTextFormField(
                        obscureText: false,
                        hintText: 'New.email@example.com',
                        keyboardType: TextInputType.emailAddress,
                        textEditingController: _emailController,
                        formKey: formKeyEmail,
                        validator: (value) {
                          return validators.validateEmail(value);
                        })
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  BuildButtonContainer(children: [
                    BuildTextFormField(
                        obscureText: true,
                        hintText: 'Password',
                        keyboardType: TextInputType.text,
                        textEditingController: _passwordController,
                        formKey: formKeyPassword,
                        validator: (value) {
                          return validators.validatePassword(value);
                        }),
                  ]),
                  BuildButtonDescriptionText(
                      text:
                          'After pressing the button you will sign out for logining with a new email. If you do not confirm your new email you can login with your current one. ')
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BuildSingleButton(
                    title: 'Update email address',
                    titleColor: Colors.white,
                    onPressed: () async {
                      resetEmail();
                    }),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
