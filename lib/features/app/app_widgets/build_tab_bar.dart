import 'package:b2clients/features/app/app_widgets/build_tab.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class BuildTabBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle1;
  final String pageTitle2;
  final String pageTitle3;
  final String pageTitle4;
  final TabController? controller;
  BuildTabBar({
    super.key,
    required this.controller,
    required this.pageTitle1,
    required this.pageTitle2,
    required this.pageTitle3,
    required this.pageTitle4,
  });

  final PageTheme theme = PageTheme();

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerHeight: 0.3,
      indicatorWeight: 0.1,
      indicatorColor: theme.statusIconColorClosedToFeedback(),
      labelColor: theme.statusIconColorClosedToFeedback(),
      unselectedLabelColor: theme.statusIconColorClosedToFeedback(),
      dividerColor: theme.tapBarDividerColor(),
      controller: controller,
      onTap: (value) {},
      tabs: <Widget>[
        BuildTab(
            title: pageTitle1,
            icon: Icons.play_arrow_rounded,
            iconColor: theme.bottomNavBarSelectedColor()),
        BuildTab(
            title: pageTitle2,
            icon: Icons.how_to_reg_rounded,
            iconColor: theme.statusIconColorIsAvailableToFeedback()),
        BuildTab(
            title: pageTitle3,
            icon: Icons.check_circle_rounded,
            iconColor: theme.statusIconColorCompleted()),
        BuildTab(
            title: pageTitle4,
            icon: Icons.cancel_rounded,
            iconColor: theme.statusIconColorCanceled()),
      ],
    );
  }
}
