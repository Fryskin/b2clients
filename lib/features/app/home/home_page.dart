import 'package:b2clients/features/app/account/account_utils.dart';
import 'package:b2clients/features/app/account/change_language_page.dart';
import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_button_container.dart';
import 'package:b2clients/features/app/app_widgets/build_link_button.dart';
import 'package:b2clients/features/app/app_widgets/build_order_list_view.dart';
import 'package:b2clients/features/app/app_widgets/build_page_description.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/export.dart';
import 'package:b2clients/features/app/support_assistent/support_quide_page.dart';
import 'package:b2clients/features/auth/export.dart';
import 'package:b2clients/features/entrance/entrance_page.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final SimpleUtils simpleUtils = SimpleUtils();
  final FirebaseUtils firebaseUtils = FirebaseUtils();
  final HomeUtils homeUtils = HomeUtils();
  final PageTheme theme = PageTheme();
  AccountUtils accountUtils = AccountUtils();

  int currentPageIndex = 2;
  int dropdawnValue = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
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

          User authData = snapshot.data!;
          firebaseUtils.updateUserAccountData({'email': authData.email});
          return StreamBuilder(
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
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              Map<String, dynamic>? userData = snapshot.data!;

              return userData['is_support_assistant'] != null &&
                      userData['is_support_assistant']
                  ? const SupportGuidePage()
                  : authData.displayName == null
                      ? Scaffold(
                          backgroundColor: theme.pageColor(),
                          appBar: BuildAppBar(
                            title: 'Language',
                          ),
                          body: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.normal,
                            ),
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                BuildPageDescription(
                                    text:
                                        'On this page you can change the language of the application.'),
                                ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      accountUtils.languages.entries.length,
                                  itemBuilder: (context, index) =>
                                      BuildButtonContainer(children: [
                                    BuildLinkButton(
                                        onPressed: () {
                                          accountUtils.changeLanguage(
                                              accountUtils.languages.entries
                                                  .elementAt(index)
                                                  .key);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SetNameAndSurnamePage(
                                                      languageCode: accountUtils
                                                          .languages.entries
                                                          .elementAt(index)
                                                          .key,
                                                    )),
                                          );
                                        },
                                        title: accountUtils.languages.entries
                                            .elementAt(index)
                                            .value,
                                        auxiliaryText: accountUtils
                                            .translatedLanguages[index]),
                                    index ==
                                            accountUtils
                                                    .languages.entries.length -
                                                1
                                        ? const Center()
                                        : theme.dividerTextFieldSettings()
                                  ]),
                                )
                              ],
                            ),
                          ),
                        )
                      : authData.emailVerified
                          ? Scaffold(
                              appBar: BuildAppBar(title: 'Home'),
                              backgroundColor: theme.pageColorGrey(),
                              body: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(
                                    decelerationRate:
                                        ScrollDecelerationRate.normal),
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        StreamBuilder(
                                            stream: homeUtils
                                                .getActiveOrdersStream(),
                                            builder: (context, snapshot) {
                                              //error
                                              if (snapshot.hasError) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              //loading
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              dropdawnValue == 0
                                                  ? snapshot.data!.sort((a, b) =>
                                                      b!['price']['from'].compareTo(
                                                          a!['price']['from']))
                                                  : dropdawnValue == 1
                                                      ? snapshot.data!.sort(
                                                          (a, b) => a!['price']
                                                                  ['from']
                                                              .compareTo(
                                                                  b!['price']
                                                                      ['from']))
                                                      : dropdawnValue == 2
                                                          ? snapshot.data!.sort(
                                                              (a, b) => b!['price']['to'].compareTo(a!['price']['to']))
                                                          : dropdawnValue == 3
                                                              ? snapshot.data!.sort((a, b) => a!['price']['to'].compareTo(b!['price']['to']))
                                                              : snapshot.data;

                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 10),
                                                        child: DropdownButton(
                                                          elevation: 1,
                                                          dropdownColor:
                                                              theme.pageColor(),
                                                          underline:
                                                              const SizedBox(
                                                            height: 0.1,
                                                          ),
                                                          isExpanded: false,
                                                          isDense: false,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          icon: const Icon(Icons
                                                              .sort_rounded),
                                                          items: <DropdownMenuItem>[
                                                            DropdownMenuItem(
                                                              value: 0,
                                                              child: const Text(
                                                                      'Highest price from')
                                                                  .translate(
                                                                      ''),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: 1,
                                                              child: const Text(
                                                                      'Lowest price from')
                                                                  .translate(
                                                                      ''),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: 2,
                                                              child: const Text(
                                                                      'Highest price to')
                                                                  .translate(
                                                                      ''),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: 3,
                                                              child: const Text(
                                                                      'Lowest price to')
                                                                  .translate(
                                                                      ''),
                                                            ),
                                                          ],
                                                          onChanged: (value) {
                                                            setState(() {
                                                              dropdawnValue =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  BuildOrderListView(
                                                      snapshot: snapshot)
                                                ],
                                              );
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              bottomNavigationBar: BottomNavigationBarWidget(
                                currentPageIndex: currentPageIndex,
                              ))
                          : Scaffold(
                              backgroundColor: theme.pageColor(),
                              appBar: AppBar(
                                elevation: 1,
                                title: theme.appBarTitle('Home').translate(''),
                                foregroundColor: theme.appBarColor(),
                                shadowColor: theme.appBarColor(),
                                backgroundColor: theme.appBarColor(),
                                surfaceTintColor: theme.appBarColor(),
                                automaticallyImplyLeading: false,
                                centerTitle: true,
                                scrolledUnderElevation:
                                    theme.elevationAppBarScrolledUnder(),
                              ),
                              body: SafeArea(
                                child: Stack(
                                  children: [
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
                                      title: theme
                                          .bodyTitle(
                                              'Your email address is not veryfied.')
                                          .translate(''),
                                      subtitle: theme
                                          .bodySubtitle(
                                              'If you do not received the mail then tap the button for resend. After verifying email, please, tap the button for refresh.')
                                          .translate(''),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        BuildSingleButton(
                                            title: 'Resend verify link',
                                            titleColor: Colors.white,
                                            onPressed: () {
                                              authData.sendEmailVerification();
                                            }),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: BuildSingleButton(
                                              title: 'Sign out',
                                              titleColor: Colors.red,
                                              onPressed: () async {
                                                await firebaseUtils.signOut();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const EntrancePage()),
                                                );
                                              },
                                            )),
                                            Expanded(
                                              child: BuildSingleButton(
                                                  title: 'Refresh',
                                                  titleColor: Colors.white,
                                                  onPressed: () {
                                                    authData.reload();
                                                  }),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ));
            },
          );
        });
  }
}
