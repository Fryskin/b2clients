import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_link_button.dart';
import 'package:b2clients/features/app/support/answer_page.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  final String questionType;
  final List questions;
  const QuestionsPage(
      {super.key, required this.questionType, required this.questions});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  PageTheme theme = PageTheme();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.pageColor(),
      appBar: BuildAppBar(
        title: widget.questionType,
        removeElevation: true,
        backgroundColor: theme.pageColor(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.normal),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.questions.length,
                  itemBuilder: (context, index) => Column(
                        children: [
                          BuildLinkButton(
                            title: widget.questions[index].keys.first,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnswerPage(
                                        question:
                                            widget.questions[index].keys.first,
                                        answer: widget
                                            .questions[index].values.first)),
                              );
                              print(widget.questions[index].values.first);
                            },
                            auxiliaryText: '',
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: theme.dividerTextFieldSupport(),
                          )
                        ],
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
