import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? goBack;
  final Widget? leading;
  final String title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool? removeElevation;

  BuildAppBar(
      {super.key,
      this.removeElevation,
      this.backgroundColor,
      this.bottom,
      this.goBack,
      this.leading,
      required this.title,
      this.actions});

  final PageTheme theme = PageTheme();
  @override
  Size get preferredSize =>
      Size.fromHeight(bottom == null ? kToolbarHeight : kToolbarHeight * 2);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: theme.appBarTitle(title).translate(''),
        actions: actions,
        leading: leading ?? const Column(),
        elevation: removeElevation != null && removeElevation! ? 0 : 1,
        shadowColor: theme.appBarColor(),
        backgroundColor: backgroundColor ?? theme.appBarColor(),
        surfaceTintColor: theme.appBarColor(),
        automaticallyImplyLeading: goBack ?? false,
        centerTitle: true,
        scrolledUnderElevation: theme.elevationAppBarScrolledUnder(),
        bottom: bottom);
  }
}
