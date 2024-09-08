import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_button_description_text.dart';
import 'package:b2clients/features/app/app_widgets/build_order_list_view.dart';
import 'package:b2clients/features/app/app_widgets/build_text_button.dart';
import 'package:b2clients/features/app/export.dart';
import 'package:b2clients/features/app/support/frequently_asked_questions_types_page.dart';

import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({
    super.key,
  });

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final PageTheme theme = PageTheme();
  final HomeUtils homeUtils = HomeUtils();
  final AccountUtils accountUtils = AccountUtils();

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
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

          Map<String, dynamic>? userData = snapshot.data!;

          return Scaffold(
              backgroundColor: theme.pageColorGrey(),
              // appBar: BuildAppBar(title: 'Support'),
              body: SafeArea(
                  child: Stack(alignment: Alignment.center, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 60, bottom: 20),
                      child: theme
                          .userNameTitle(
                              'Hello, ${userData['name']}!\nHow can we help you?')
                          .translate(''),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          theme.bodyTitle('My orders').translate(''),
                          BuildTextButton(
                            onPressed: () {},
                            title: 'Show all',
                            addArrow: true,
                          )
                        ],
                      ),
                    ),
                    StreamBuilder(
                        stream: homeUtils.getChainedOrdersStream(),
                        builder: (context, snapshot) {
                          //error
                          if (snapshot.hasError) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          //loading
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: 168,
                            child: BuildOrderListView(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ChatPage(
                                      receiverID:
                                          'pLWT7wGv17OiQGWkSGY4JkwSXhU2',
                                      receiverName: 'Support',
                                      receiverSurname: 'Assistant',
                                    ),
                                  ),
                                );
                              },
                              snapshot: snapshot,
                              addSizedBox: false,
                              scrollDirection: Axis.horizontal,
                            ),
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: theme.bodyTitle('Other').translate(''),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ChatPage(
                                          receiverID:
                                              'pLWT7wGv17OiQGWkSGY4JkwSXhU2',
                                          receiverName: 'Support',
                                          receiverSurname: 'Assistant',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 250, 245, 177),
                                    ),
                                    height: 200,
                                    width: MediaQuery.sizeOf(context).width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: theme
                                          .bodyTitleBold(
                                              'Contact a support representative')
                                          .translate(''),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FrequentlyAskedQuestionsTypesPage()),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 250, 245, 177),
                                    ),
                                    height: 200,
                                    width: MediaQuery.sizeOf(context).width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: theme
                                          .bodyTitleBold(
                                              'View answers to frequently asked questions')
                                          .translate(''),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ])),
              bottomNavigationBar: BottomNavigationBarWidget(
                currentPageIndex: currentPageIndex,
              ));
        });
  }
}
