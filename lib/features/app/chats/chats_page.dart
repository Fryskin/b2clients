import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/export.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({
    super.key,
  });

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final ChatService _chatService = ChatService();
  PageTheme theme = PageTheme();
  int currentPageIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.pageColor(),
        appBar: BuildAppBar(title: 'Chats'),
        body: _buildUserList(),
        bottomNavigationBar: BottomNavigationBarWidget(
          currentPageIndex: currentPageIndex,
        ));
  }

  // build a list of users exept for the current logged user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text('error');
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }
        // return list view
        return ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal),
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all yousers except current user
    return UserTile(
      text: '${userData['name']} ${userData['surname']}',
      onTap: () {
        // go to chat page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverID: userData['uid'],
              receiverName: userData['name'],
              receiverSurname: userData['surname'],
            ),
          ),
        );
      },
      profileImageURL: userData['profile_image'],
    );
  }
}
