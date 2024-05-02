import 'package:flutter/material.dart';

const whiteColor = Color.fromARGB(255, 233, 233, 233);
final theme = ThemeData(
  useMaterial3: true,
  cardTheme: const CardTheme(),
  primaryColor: whiteColor,
  listTileTheme: const ListTileThemeData(),
  dividerTheme: const DividerThemeData(
      thickness: 20, color: Color.fromARGB(255, 241, 242, 246)),
  textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 20),
      labelSmall:
          TextStyle(fontSize: 15, color: Color.fromARGB(255, 116, 116, 116))),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 26, 26, 26),
      centerTitle: true,
      iconTheme: IconThemeData(color: whiteColor),
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontSize: 25,
      )),
);
