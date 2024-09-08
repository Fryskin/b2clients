import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class BuildButtonContainer extends StatelessWidget {
  final List<Widget> children;
  BuildButtonContainer({super.key, required this.children});

  final PageTheme theme = PageTheme();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: theme.cardShapeBorderOnly(),
      shadowColor: theme.cardColorWhite(),
      surfaceTintColor: theme.cardColorWhite(),
      color: theme.cardColorWhite(),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Column(
        children: children,
      ),
    );
  }
}
