import 'package:b2clients/router/router.dart';

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BusinessToClientsApp extends StatelessWidget {
  final String languageCode;
  const BusinessToClientsApp({super.key, required this.languageCode});
  final String apiKey = 'AIzaSyB2qZLd7maHTp_VtAJvI5JQFuGSSDUIjmA';

  @override
  Widget build(BuildContext context) {
    return GoogleTranslatorInit(
      apiKey,
      cacheDuration: const Duration(days: 30),
      translateFrom: const Locale('en'),
      translateTo: Locale(languageCode),
      builder: () => MaterialApp(
        title: 'Business To Clients',
        // theme: theme,
        routes: routes,
        // initialRoute: '',
        // home: const MainPage(),
      ),
    );
  }
}
