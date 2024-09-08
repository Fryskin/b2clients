import 'package:b2clients/features/app/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuildOrderListView extends StatelessWidget {
  final AsyncSnapshot<List<Map<String, dynamic>?>> snapshot;
  final bool? addSizedBox;
  final Axis? scrollDirection;
  final void Function()? onTap;
  const BuildOrderListView(
      {super.key,
      this.onTap,
      required this.snapshot,
      this.addSizedBox,
      this.scrollDirection});

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const PageScrollPhysics(),
        scrollDirection: scrollDirection ?? Axis.vertical,
        shrinkWrap: true,
        children: snapshot.data!
            .map((orderData) => Column(
                  children: [
                    addSizedBox != null && !addSizedBox!
                        ? const Column()
                        : const SizedBox(
                            height: 20,
                          ),
                    BuildOrderCardWidget(
                      onTap: onTap,
                      orderID: orderData!['order_id'].toString(),
                      orderUID: orderData['uid'],
                    ),
                  ],
                ))
            .toList());
  }
}
