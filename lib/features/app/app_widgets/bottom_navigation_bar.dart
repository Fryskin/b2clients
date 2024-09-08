import 'package:b2clients/features/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int currentPageIndex;
  const BottomNavigationBarWidget({
    super.key,
    required this.currentPageIndex,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  PageTheme theme = PageTheme();

  late int currentPageIndex = widget.currentPageIndex;

  dynamic getPage(int currentPageIndex) {
    List bottomBarPages = [
      const SupportPage(),
      const FeedbacksHistoryPage(),
      const EntrancePage(),
      const ChatsPage(),
      const AccountPage()
    ];
    return bottomBarPages[currentPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        theme.divider(),
        NavigationBar(
            elevation: theme.elevationBottomNavBar(),
            surfaceTintColor: theme.appBarColor(),
            shadowColor: theme.appBarColor(),
            height: theme.heightBottomNavBar(),
            backgroundColor: theme.appBarColor(),
            onDestinationSelected: (int index) async {
              if (currentPageIndex != index) {
                currentPageIndex = index;

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => getPage(currentPageIndex)),
                );
              }
            },
            indicatorColor: theme.appBarColor(),
            selectedIndex: currentPageIndex,
            destinations: theme.bottomNavBar()),
      ],
    );
  }
}
