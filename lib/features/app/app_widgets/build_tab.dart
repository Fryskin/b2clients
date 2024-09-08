import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class BuildTab extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  BuildTab(
      {super.key,
      required this.title,
      required this.icon,
      required this.iconColor});
  final PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 56.5,
      text: title,
      icon: Icon(
        icon,
        size: 25,
        color: iconColor,
      ),
    );
  }
}
