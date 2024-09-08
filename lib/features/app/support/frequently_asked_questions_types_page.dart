import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_link_button.dart';
import 'package:b2clients/features/app/support/questions_page.dart';
import 'package:b2clients/features/app/support/support_utils.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class FrequentlyAskedQuestionsTypesPage extends StatefulWidget {
  const FrequentlyAskedQuestionsTypesPage({super.key});

  @override
  State<FrequentlyAskedQuestionsTypesPage> createState() =>
      _FrequentlyAskedQuestionsTypesPageState();
}

class _FrequentlyAskedQuestionsTypesPageState
    extends State<FrequentlyAskedQuestionsTypesPage> {
  PageTheme theme = PageTheme();
  SupportUtils supportUtils = SupportUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.pageColor(),
      appBar: BuildAppBar(
        title: 'Types of questions',
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              StreamBuilder(
                  stream: supportUtils.getQuestionsStream(),
                  builder: (context, snapshot) {
                    //error
                    if (snapshot.hasError) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    //loading
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    Map<String, dynamic>? questionsTypes = snapshot.data!;
                    return ListView(
                        padding: const EdgeInsets.only(top: 5),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: questionsTypes['frequently_asked_questions']
                            .map<Widget>((questionType) => Column(
                                  children: [
                                    BuildLinkButton(
                                      title: questionType.keys.first,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QuestionsPage(
                                                      questionType: questionType
                                                          .keys.first,
                                                      questions: questionType
                                                          .values.first)),
                                        );
                                      },
                                      auxiliaryText: '',
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: theme.dividerTextFieldSupport(),
                                    )
                                  ],
                                ))
                            .toList());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
