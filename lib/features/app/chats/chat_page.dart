import 'package:b2clients/features/app/app_widgets/build_app_bar.dart';
import 'package:b2clients/features/app/chats/chat_utils.dart';
import 'package:b2clients/features/export.dart';
import 'package:b2clients/services/export.dart';
import 'package:b2clients/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class ChatPage extends StatefulWidget {
  final String receiverID;
  final String receiverName;
  final String receiverSurname;

  const ChatPage({
    super.key,
    required this.receiverID,
    required this.receiverName,
    required this.receiverSurname,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  PageTheme theme = PageTheme();
  ChatsUtils chatsUtils = ChatsUtils();
  FirebaseUtils firebaseUtils = FirebaseUtils();
  HomeUtils homeUtils = HomeUtils();

  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  FocusNode myFocusNode = FocusNode();
  int counter = 0;

  String lastSendingDay = '';
  String previousSendingDay = '';
  bool showSendingDay = true;
  Timestamp lastSendingTime = Timestamp.now();
  Timestamp previousSendingTime = Timestamp.now();

  bool addSpase = false;

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 600),
          () => chatsUtils.scrollDown(_scrollController),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 200),
      () => chatsUtils.scrollDown(_scrollController),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.pageColor(),
      appBar: BuildAppBar(
        title: '${widget.receiverName} ${widget.receiverSurname}',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.4,
            image: AssetImage("assets/images/background_chat.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: _buildMessageList()),
            const SizedBox(
              height: 5,
            ),
            _buildUserInput(),
          ],
        ),
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderID = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          // on error
          if (snapshot.hasError) {
            return const Text('error');
          }
          // on waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }
          // on success
          if (counter < snapshot.data!.docs.length) {
            Future.delayed(
              const Duration(milliseconds: 100),
              () => chatsUtils.scrollDown(_scrollController),
            );
          }
          counter = snapshot.data!.docs.length;
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 5),
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal,
            ),
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String messageDocID = doc.reference.id;
    //is current user
    bool isUserCurrent =
        data['sender_id'] == FirebaseAuth.instance.currentUser!.uid;

    !isUserCurrent
        ? firebaseUtils
            .secondFirestore()
            .collection('chat_rooms')
            .doc(
                '${widget.receiverID}_${FirebaseAuth.instance.currentUser!.uid}')
            .collection('messages')
            .doc(messageDocID)
            .update({'isRead': true})
        : null;

    Timestamp sendingTime = data['timestamp'];
    String sendingDay = sendingTime.toDate().day.toString();
    String sendingMounth = homeUtils.monthsList[sendingTime.toDate().month];
    lastSendingDay = '$sendingDay $sendingMounth';
    previousSendingDay != lastSendingDay
        ? showSendingDay = true
        : showSendingDay = false;

    previousSendingDay = lastSendingDay;

    lastSendingTime = data['timestamp'];

    Duration sendingDifference =
        lastSendingTime.toDate().difference(previousSendingTime.toDate());
    sendingDifference < const Duration(minutes: 30)
        ? addSpase = false
        : addSpase = true;

    previousSendingTime = lastSendingTime;
    //align to the right if iths current use, otherwise-left
    var alignment =
        isUserCurrent ? Alignment.centerRight : Alignment.centerLeft;

    return Column(
      children: [
        showSendingDay
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: theme.pastelBlue(),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2.5),
                        child: sendingTime.toDate().year != DateTime.now().year
                            ? theme
                                .defaultText(
                                    '$lastSendingDay ${sendingTime.toDate().year}')
                                .translate('')
                            : sendingDay != DateTime.now().day.toString() ||
                                    sendingTime.toDate().month !=
                                        DateTime.now().month
                                ? theme
                                    .defaultText(lastSendingDay)
                                    .translate('')
                                : theme.defaultText('Today').translate(''),
                      )
                    ],
                  ),
                ),
              )
            : const Column(),
        Container(
          alignment: alignment,
          child: Column(
            crossAxisAlignment: isUserCurrent
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ChatBuble(
                isSenderIsCrrentUser: isUserCurrent,
                isRead: data['isRead'] ?? false,
                addSpace: addSpase,
                isUserCurrent: isUserCurrent,
                message: data['message'],
                timestamp: data['timestamp'],
              )
            ],
          ),
        ),
      ],
    );
  }

  // user input
  Widget _buildUserInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: theme.appBarColor(),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: TextFormField(
                  focusNode: myFocusNode,
                  onChanged: (value) {
                    _messageController.value.isComposingRangeValid;
                  },
                  onTap: () {
                    chatsUtils.scrollDownOnTap(_scrollController);
                  },
                  minLines: 1,
                  maxLines: 9,
                  controller: _messageController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    filled: true,
                    fillColor: theme.cardColorWhite(),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.pageColorGrey(), width: 7),
                        borderRadius: BorderRadius.circular(25)),
                    // focusColor: Color.fromARGB(255, 173, 182, 187),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.pageColorGrey(), width: 7),
                        borderRadius: BorderRadius.circular(25)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.pageColorGrey(), width: 7),
                        borderRadius: BorderRadius.circular(25)),
                    hintText: 'Message',
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(right: 5, left: 2),
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 251, 186, 60),
                  ),
                  child: IconButton(
                      onPressed: () {
                        chatsUtils.sendMessage(_scrollController,
                            _messageController, widget.receiverID);
                      },
                      icon: const Icon(
                        Icons.arrow_upward_rounded,
                        size: 18,
                        fill: 1,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
