import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

class WorksheetPage extends StatefulWidget {
  const WorksheetPage({super.key});

  @override
  State<WorksheetPage> createState() => _WorksheetPageState();
}

class _WorksheetPageState extends State<WorksheetPage> {
  String? worksheetTitle;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String, 'You must provide String');

    // if (args == null) {
    //   log('You must provide arguments');
    //   return;
    // }
    // if (args is! String) {
    //   log('You must provide String');
    //   return;
    // } else {
    //   log('Yeeeeeea bitch!');
    // }
    worksheetTitle = args as String;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final appBarTheme = AppBarTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarTheme.backgroundColor,
        iconTheme: appBarTheme.iconTheme,
        title: Text(worksheetTitle ?? '...'),
      ),
    );
  }
}
