import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final dynamic profileImageURL;

  UserTile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.profileImageURL});

  PageTheme theme = PageTheme();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              color: theme.pageColor(),
              child: Row(
                children: [
                  profileImageURL != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(profileImageURL),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage:
                                AssetImage('assets/images/profile-icon.png'),
                          )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      theme.bodyTitleBold(text),
                      theme.defaultText('message'),
                    ],
                  )
                ],
              )),
          theme.chatsPageDivider()
        ],
      ),
    );
  }
}
