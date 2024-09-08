import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class AnswerPage extends StatelessWidget {
  final String question;
  final String answer;
  AnswerPage({super.key, required this.question, required this.answer});
  final PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.pageColor(),
      appBar: BuildAppBar(
          title: question,
          backgroundColor: theme.pageColor(),
          removeElevation: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.normal),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
          child: Row(
            children: [
              Flexible(child: theme.bodyTitleSettings(answer)),
            ],
          ),
        ),
      ),
    );
  }
}
