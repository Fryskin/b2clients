import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_order_list_view.dart';
import 'package:b2clients/features/app/app_widgets/build_tab_bar.dart';
import 'package:b2clients/features/app/export.dart';

import 'package:b2clients/features/export.dart';
import 'package:b2clients/services/export.dart';

import 'package:b2clients/theme/theme.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:translator_plus/translator_plus.dart';

class FeedbacksHistoryPage extends StatefulWidget {
  const FeedbacksHistoryPage({super.key});

  @override
  State<FeedbacksHistoryPage> createState() => _FeedbacksHistoryPageState();
}

class _FeedbacksHistoryPageState extends State<FeedbacksHistoryPage>
    with TickerProviderStateMixin {
  PageTheme theme = PageTheme();
  HomeUtils homeUtils = HomeUtils();
  FirebaseUtils firebaseUtils = FirebaseUtils();
  int currentPageIndex = 1;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List pages = ['Responded', 'Confirmed', 'Completed', 'Canceled'];
  List translatedPages = [];

  Future translatePages() async {
    Map userData = await firebaseUtils.getAccountData();

    for (String page in pages) {
      Translation translatedPage =
          await page.translate(to: userData['language_code']);

      translatedPages.add(translatedPage.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: translatePages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return DefaultTabController(
            initialIndex: 0,
            length: 4,
            child: Scaffold(
                backgroundColor: theme.pageColorGrey(),
                appBar: BuildAppBar(
                  title: 'History of your feedbacks',
                  bottom: BuildTabBar(
                      controller: _tabController,
                      pageTitle1: translatedPages[0],
                      pageTitle2: translatedPages[1],
                      pageTitle3: translatedPages[2],
                      pageTitle4: translatedPages[3]),
                ),
                body: TabBarView(controller: _tabController, children: [
                  StreamBuilder(
                      stream: homeUtils.getRespondedOrdersStream(),
                      builder: (context, snapshot) {
                        return buildOrderListViewPage(snapshot);
                      }),
                  StreamBuilder(
                      stream: homeUtils.getConfirmedOrdersStream(),
                      builder: (context, snapshot) {
                        return buildOrderListViewPage(snapshot);
                      }),
                  StreamBuilder(
                      stream: homeUtils.getCompletedOrdersStream(),
                      builder: (context, snapshot) {
                        return buildOrderListViewPage(snapshot);
                      }),
                  StreamBuilder(
                      stream: homeUtils.getCanceledOrdersStream(),
                      builder: (context, snapshot) {
                        return buildOrderListViewPage(snapshot);
                      }),
                ]),
                bottomNavigationBar: BottomNavigationBarWidget(
                  currentPageIndex: currentPageIndex,
                )),
          );
        });
  }

  Widget buildOrderListViewPage(
      AsyncSnapshot<List<Map<String, dynamic>?>> snapshot) {
    //error
    if (snapshot.hasError) {
      return const Text('error');
    }
    //loading
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [BuildOrderListView(snapshot: snapshot)],
      ),
    );
  }
}
