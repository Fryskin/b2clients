import 'package:b2clients/features/app/support_assistent/support_widgets/build_support_bottom_nav_bar.dart';
import 'package:b2clients/features/app/support_assistent/support_widgets/build_support_tab_bar.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class ChatsForOrdersPage extends StatefulWidget {
  const ChatsForOrdersPage({super.key});

  @override
  State<ChatsForOrdersPage> createState() => _ChatsForOrdersPageState();
}

class _ChatsForOrdersPageState extends State<ChatsForOrdersPage>
    with TickerProviderStateMixin {
  PageTheme theme = PageTheme();
  late final TabController _tabController;
  late int currentPageIndex = 0;

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
