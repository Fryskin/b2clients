import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/app_widgets/build_page_description.dart';
import 'package:b2clients/features/app/app_widgets/build_single_button.dart';
import 'package:b2clients/features/app/app_widgets/build_text_form_field.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'set_or_update_city_page.dart';

class SetOrUpdateSuitablePricePage extends StatefulWidget {
  final int pageIndex;
  final int pagesCount;
  final String accountDocumentID;
  final String languageCode;
  final List userServiceTypes;
  final List pricesMapList;
  final Map pricesData;

  const SetOrUpdateSuitablePricePage(
      {super.key,
      required this.pricesMapList,
      required this.pricesData,
      required this.pageIndex,
      required this.accountDocumentID,
      required this.userServiceTypes,
      required this.languageCode,
      required this.pagesCount});

  @override
  State<SetOrUpdateSuitablePricePage> createState() =>
      _SetOrUpdateSuitablePricePageState();
}

class _SetOrUpdateSuitablePricePageState
    extends State<SetOrUpdateSuitablePricePage> {
  final PageTheme theme = PageTheme();
  final SimpleUtils utils = SimpleUtils();
  final FirebaseUtils firebaseUtils = FirebaseUtils();
  final formKeyFrom = GlobalKey<FormState>();
  final formKeyTo = GlobalKey<FormState>();
  final TextEditingController _priceFromController = TextEditingController();
  final TextEditingController _priceToController = TextEditingController();

  late List pricesMapList = widget.pricesMapList;

  @override
  void dispose() {
    _priceFromController.dispose();
    _priceToController.dispose();
    super.dispose();
  }

  int servicePriceFrom() {
    return widget.pricesData[widget.userServiceTypes[widget.pageIndex]]['from'];
  }

  int servicePriceTo() {
    return widget.pricesData[widget.userServiceTypes[widget.pageIndex]]['to'];
  }

  String servicePriceSymbol() {
    return widget.pricesData[widget.userServiceTypes[widget.pageIndex]]
        ['symbol'];
  }

  Future addPricesToAccount() async {
    pricesMapList.add({
      'from': int.parse(_priceFromController.text),
      'symbol': servicePriceSymbol(),
      'to': int.parse(_priceToController.text),
    });

    if (widget.pageIndex + 1 == widget.pagesCount) {
      Map<Object, Object?> pricesMap = {};

      for (int i = 0; i < pricesMapList.length; i++) {
        pricesMap[widget.userServiceTypes[i]] = pricesMapList[i];
      }
      firebaseUtils.updateUserAccountData({'prices': pricesMap});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.pageColorGrey(),
      appBar: BuildAppBar(
        title: utils.toTitleCase(widget.userServiceTypes[widget.pageIndex]),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            if (widget.pricesMapList.isNotEmpty) {
              widget.pricesMapList.removeLast();
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                BuildPageDescription(
                    text:
                        'What price range do you prefer in the "${utils.toTitleCase(widget.userServiceTypes[widget.pageIndex])}" industry? Usually people pay from ${servicePriceFrom()} to ${servicePriceTo()} ${servicePriceSymbol()} for this service.\n\nSelect most suiteble price range for you.'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                      obscureText: false,
                      hintText: 'From',
                      keyboardType: TextInputType.number,
                      textEditingController: _priceFromController,
                      formKey: formKeyFrom,
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Enter the price'
                            : int.parse(value) <= 0
                                ? 'Price must be over then 0'
                                : int.parse(_priceFromController.text) >=
                                        int.parse(_priceToController.text)
                                    ? 'Price From must be lowest then price To'
                                    : null;
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BuildTextFormField(
                      obscureText: false,
                      hintText: 'To',
                      keyboardType: TextInputType.number,
                      textEditingController: _priceToController,
                      formKey: formKeyTo,
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Enter the price'
                            : int.parse(value) <= 0
                                ? 'Price must be over then 0'
                                : null;
                      }),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BuildSingleButton(
                    title: 'Continue',
                    titleColor: Colors.white,
                    onPressed: () {
                      if (formKeyFrom.currentState!.validate() &&
                          formKeyTo.currentState!.validate()) {
                        if (widget.pageIndex + 1 == widget.pagesCount) {
                          addPricesToAccount();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SetOrUpdateCityPage(
                                        pricesMapList: pricesMapList,
                                        languageCode: widget.languageCode,
                                      )));
                        } else {
                          addPricesToAccount();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SetOrUpdateSuitablePricePage(
                                          languageCode: widget.languageCode,
                                          pricesMapList: pricesMapList,
                                          pricesData: widget.pricesData,
                                          pageIndex: widget.pageIndex + 1,
                                          accountDocumentID:
                                              widget.accountDocumentID,
                                          userServiceTypes:
                                              widget.userServiceTypes,
                                          pagesCount: widget.pagesCount)));
                        }
                      }
                    }),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
