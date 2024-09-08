import 'package:b2clients/features/app/support_assistent/chats_for_orders_page.dart';
import 'package:b2clients/features/app/support_assistent/contact_with_users_page.dart';
import 'package:b2clients/features/app/support_assistent/support_quide_page.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class BuildSupportBottomNavBar extends StatefulWidget {
  final int currentPageIndex;
  const BuildSupportBottomNavBar({
    super.key,
    required this.currentPageIndex,
  });

  @override
  State<BuildSupportBottomNavBar> createState() =>
      _BuildSupportBottomNavBarState();
}

class _BuildSupportBottomNavBarState extends State<BuildSupportBottomNavBar> {
  PageTheme theme = PageTheme();

  late int currentPageIndex = widget.currentPageIndex;

  dynamic getPage(int currentPageIndex) {
    List bottomBarPages = [
      const ChatsForOrdersPage(),
      const SupportGuidePage(),
      const ContactWithUsersPage(),
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
              if (widget.currentPageIndex != index) {
                currentPageIndex = index;

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => getPage(currentPageIndex)),
                );
              }
            },
            indicatorColor: theme.appBarColor(),
            selectedIndex: widget.currentPageIndex,
            destinations: [
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.chat_bubble_rounded,
                  color: theme.bottomNavBarSelectedColor(),
                  size: 32,
                ),
                icon: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 32,
                ),
                label: 'Chats for orders',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.live_help_rounded,
                  color: theme.bottomNavBarSelectedColor(),
                  size: 31,
                ),
                icon: const Icon(
                  Icons.live_help_outlined,
                  size: 31,
                ),
                label: 'Guide',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.headset_mic_rounded,
                  color: theme.bottomNavBarSelectedColor(),
                  size: 30,
                ),
                icon: const Icon(
                  Icons.headset_mic_outlined,
                  size: 30,
                ),
                label: 'Contact with users',
              ),
            ]),
      ],
    );
  }
}
