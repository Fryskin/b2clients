import 'package:b2clients/features/auth/set_or_update_suitable_price_page.dart';
import 'package:flutter/cupertino.dart';

class DefinePricesCountPage extends StatefulWidget {
  final List userServiceTypes;
  final String accountDocumentID;
  final String languageCode;
  final Map pricesData;
  const DefinePricesCountPage({
    super.key,
    required this.pricesData,
    required this.languageCode,
    required this.userServiceTypes,
    required this.accountDocumentID,
  });

  @override
  State<DefinePricesCountPage> createState() => _DefinePricesCountPageState();
}

class _DefinePricesCountPageState extends State<DefinePricesCountPage> {
  int pricesPagesCount() {
    return widget.userServiceTypes.length;
  }

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SetOrUpdateSuitablePricePage(
      languageCode: widget.languageCode,
      pricesMapList: [],
      pricesData: widget.pricesData,
      userServiceTypes: widget.userServiceTypes,
      pagesCount: pricesPagesCount(),
      accountDocumentID: widget.accountDocumentID,
      pageIndex: pageIndex,
    );
  }
}
