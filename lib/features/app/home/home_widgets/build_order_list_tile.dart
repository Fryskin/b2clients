import 'package:b2clients/features/app/app_widgets/build_tile_description.dart';
import 'package:b2clients/services/simple_utils.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class BuildOrderListTile extends StatefulWidget {
  final dynamic descriptionTitle;
  final dynamic descriptionInfo;
  const BuildOrderListTile(
      {super.key,
      required this.descriptionInfo,
      required this.descriptionTitle});

  @override
  State<BuildOrderListTile> createState() => _BuildOrderListTileState();
}

class _BuildOrderListTileState extends State<BuildOrderListTile> {
  SimpleUtils utils = SimpleUtils();
  PageTheme theme = PageTheme();

  @override
  Widget build(BuildContext context) {
    return widget.descriptionInfo.toString() == '[Without special requirements]'
        ? const Column()
        : Column(
            children: [
              BuildTileDescription(
                  title: widget.descriptionTitle,
                  subtitle: widget.descriptionInfo
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', '')),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }
}
