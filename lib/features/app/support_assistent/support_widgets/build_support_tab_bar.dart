import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_tab.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class BuildSupportTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TabController? controller;
  BuildSupportTabBar({super.key, required this.controller});

  final PageTheme theme = PageTheme();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: const EdgeInsets.only(top: 59.1),
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
            title: 'Active',
            icon: Icons.play_arrow_rounded,
            iconColor: Colors.blue),
        BuildTab(
            title: 'Completed',
            icon: Icons.check_circle_rounded,
            iconColor: theme.statusIconColorCompleted()),
      ],
    );
  }
}
