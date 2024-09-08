import 'package:b2clients/features/app/account/change_language_page.dart';
import 'package:b2clients/features/app/app_widgets/build_button_container.dart';
import 'package:b2clients/features/app/app_widgets/build_link_iconed_button.dart';
import 'package:b2clients/features/app/export.dart';
import 'package:b2clients/features/export.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';

import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    super.key,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  SimpleUtils simpleUtils = SimpleUtils();
  ImagePickerService imagePickerService = ImagePickerService();
  AccountUtils accountUtils = AccountUtils();
  PageTheme theme = PageTheme();

  int currentPageIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 40,
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
                    theme.userNameTitle(
                        '${userData['name']} ${userData['surname']}'),
                    theme.bodyTitle(userData['email']),
                    const SizedBox(
                      height: 20,
                    ),
                    BuildButtonContainer(
                      children: [
                        BuildLinkIconedButton(
                            onPressed: () async {
                              imagePickerService.submitImage();
                            },
                            icon: const Icon(
                              Icons.photo_camera_rounded,
                              size: 28,
                              color: Colors.black,
                            ),
                            title: 'Change photo',
                            auxiliaryText: ''),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BuildButtonContainer(children: [
                      BuildLinkIconedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FeedbacksHistoryPage()),
                            );
                          },
                          icon: const Icon(
                            Icons.home_repair_service_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: 'Orders',
                          auxiliaryText: ''),
                      theme.dividerTextFieldIconSettings(),
                      BuildLinkIconedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangeUserInfoPage()),
                            );
                          },
                          icon: const Icon(
                            Icons.settings,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: 'My info',
                          auxiliaryText: ''),
                      theme.dividerTextFieldIconSettings(),
                      BuildLinkIconedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeLanguagePage(
                                      iterationType: 'update',
                                      languageCode: userData['language_code'])),
                            );
                          },
                          icon: const Icon(
                            Icons.language_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: 'Language',
                          auxiliaryText: ''),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    BuildButtonContainer(children: [
                      BuildLinkIconedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage(
                                        workerDocumentID: userData['uid'],
                                      )),
                            );
                          },
                          icon: const Icon(
                            Icons.person,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: 'About myself',
                          auxiliaryText: ''),
                      theme.dividerTextFieldIconSettings(),
                      BuildLinkIconedButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.badge_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: 'Work experience',
                          auxiliaryText: ''),
                      theme.dividerTextFieldIconSettings(),
                      BuildLinkIconedButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.school_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: 'Education',
                          auxiliaryText: ''),
                      theme.dividerTextFieldIconSettings(),
                      BuildLinkIconedButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.emoji_events_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: 'Achievements',
                          auxiliaryText: '')
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    BuildButtonContainer(children: [
                      BuildLinkIconedButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.home_work_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: "Where I'm working",
                          auxiliaryText:
                              '${accountUtils.getAddressString(userData['location']['city']['prague']['areas']).substring(0, 6)}...'),
                      theme.dividerTextFieldIconSettings(),
                      BuildLinkIconedButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.design_services_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: "What I'm doing",
                          auxiliaryText:
                              '${simpleUtils.toTitleCase(userData['service_types'][0])}...'),
                      theme.dividerTextFieldIconSettings(),
                      BuildLinkIconedButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.payments_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: "Suitable price",
                          auxiliaryText: ''),
                      theme.dividerTextFieldIconSettings(),
                      BuildLinkIconedButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.image_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: "Photos",
                          auxiliaryText: ''),
                      theme.dividerTextFieldIconSettings(),
                      BuildLinkIconedButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.photo_library_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          title: "Photo albums",
                          auxiliaryText: '')
                    ]),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            }),
        bottomNavigationBar: BottomNavigationBarWidget(
          currentPageIndex: currentPageIndex,
        ));
  }
}
