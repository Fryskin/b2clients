import 'package:b2clients/router/router.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class BusinessToClientsApp extends StatelessWidget {
  const BusinessToClientsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business To Clients',
      theme: theme,
      routes: routes,
      // initialRoute: '',
      // home: const MainPage(),
    );
  }
}
