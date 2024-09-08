import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/support_assistent/support_widgets/build_support_bottom_nav_bar.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SupportGuidePage extends StatefulWidget {
  const SupportGuidePage({super.key});

  @override
  State<SupportGuidePage> createState() => _SupportGuidePageState();
}

class _SupportGuidePageState extends State<SupportGuidePage> {
  PageTheme theme = PageTheme();
  late int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.pageColor(),
      appBar: BuildAppBar(
        title: 'Support guide',
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                setState(() {});
              },
              icon: const Icon(
                Icons.logout_rounded,
                size: 30,
                color: Colors.black,
              ))
        ],
      ),
      bottomNavigationBar: BuildSupportBottomNavBar(
        currentPageIndex: currentPageIndex,
      ),
    );
  }
}
