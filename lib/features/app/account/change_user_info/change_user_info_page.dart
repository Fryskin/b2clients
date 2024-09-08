import 'package:b2clients/features/app/app_utils/validators.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/build_button_container.dart';
import 'package:b2clients/features/app/app_widgets/build_button_description_text.dart';
import 'package:b2clients/features/app/app_widgets/build_link_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_form_field.dart';
import 'package:b2clients/features/export.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';

import 'package:flutter/material.dart';

class ChangeUserInfoPage extends StatefulWidget {
  const ChangeUserInfoPage({
    super.key,
  });

  @override
  State<ChangeUserInfoPage> createState() => _ChangeUserInfoPageState();
}

class _ChangeUserInfoPageState extends State<ChangeUserInfoPage> {
  FirebaseUtils utils = FirebaseUtils();
  PageTheme theme = PageTheme();
  SimpleUtils simpleUtils = SimpleUtils();
  Validators validators = Validators();
  AccountUtils accountUtils = AccountUtils();

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeySurame = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.pageColorGrey(),
        body: StreamBuilder(
            stream: accountUtils.getUserStream(),
            builder: (context, snapshot) {
              //error
              if (snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              Map<String, dynamic>? userData = snapshot.data!;

              nameController.text = userData['name'];
              surnameController.text = userData['surname'];

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildTextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AccountPage()),
                              );
                            },
                            title: 'Go back',
                          ),
                          BuildTextButton(
                            onPressed: () {
                              if (_formKeyName.currentState!.validate() &&
                                  _formKeySurame.currentState!.validate()) {
                                accountUtils.updateNameAndSurname(
                                    nameController, surnameController);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AccountPage()),
                                );
                              }
                            },
                            title: 'Confirm',
                          )
                        ],
                      ),
                    ),
                    userData['profile_image'] != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(userData['profile_image']),
                          )
                        : const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/profile-icon.png'),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    BuildButtonContainer(children: [
                      BuildTextFormField(
                        obscureText: false,
                        hintText: '',
                        keyboardType: TextInputType.text,
                        textEditingController: nameController,
                        formKey: _formKeyName,
                        validator: (value) {
                          return validators.validateUpperAndLowerCase(value);
                        },
                      ),
                      theme.dividerTextFieldSettings(),
                      BuildTextFormField(
                        obscureText: false,
                        hintText: '',
                        keyboardType: TextInputType.text,
                        textEditingController: surnameController,
                        formKey: _formKeySurame,
                        validator: (value) {
                          return validators.validateUpperAndLowerCase(value);
                        },
                      ),
                    ]),
                    BuildButtonDescriptionText(
                        text:
                            'Enter your name and surname, clients will see your name when viewing your info.'),
                    BuildButtonContainer(children: [
                      BuildLinkButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePhoneNumberPage()),
                            );
                            setState(() {});
                          },
                          title: 'Phone number',
                          auxiliaryText:
                              userData['phone_number'].toString().isNotEmpty
                                  ? userData['phone_number']
                                  : 'not specified'),
                      theme.dividerTextFieldSettings(),
                      BuildLinkButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangeEmailAddressPage()),
                            );
                          },
                          title: 'Email',
                          auxiliaryText: userData['email']),
                    ]),
                    const SizedBox(
                      height: 40,
                    ),
                    BuildSingleButton(
                      title: 'Delete account',
                      titleColor: Colors.white,
                      onPressed: () async {
                        await utils.deleteAccount();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EntrancePage()),
                        );
                      },
                    ),
                    BuildButtonDescriptionText(
                      text:
                          'You can delete your account, your account will be deleted permanently. You can always create a new one.',
                    ),
                    BuildSingleButton(
                      title: 'Sign out',
                      titleColor: Colors.red,
                      onPressed: () async {
                        await utils.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EntrancePage()),
                        );
                      },
                    ),
                  ],
                ),
              );
            }));
  }
}
