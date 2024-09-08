import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/support_assistent/support_widgets/build_support_bottom_nav_bar.dart';
import 'package:b2clients/features/app/support_assistent/support_widgets/build_support_tab_bar.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class ContactWithUsersPage extends StatefulWidget {
  const ContactWithUsersPage({super.key});

  @override
  State<ContactWithUsersPage> createState() => _ContactWithUsersPageState();
}

class _ContactWithUsersPageState extends State<ContactWithUsersPage>
    with TickerProviderStateMixin {
  PageTheme theme = PageTheme();
  late final TabController _tabController;
  late int currentPageIndex = 2;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: theme.pageColor(),
        appBar: BuildSupportTabBar(controller: _tabController),
        body: TabBarView(
          controller: _tabController,
          children: [Center(), Center()],
        ),
        bottomNavigationBar: BuildSupportBottomNavBar(
          currentPageIndex: currentPageIndex,
        ),
      ),
    );
  }
}
