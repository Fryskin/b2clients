import 'package:b2clients/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatsUtils {
  final ChatService chatService = ChatService();

  void sendMessage(ScrollController scrollController,
      TextEditingController messageController, String receiverID) async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(receiverID, messageController.text.trim());

      messageController.clear();
      Future.delayed(
        const Duration(milliseconds: 200),
        () => scrollDown(scrollController),
      );
    }
  }

  void scrollDown(ScrollController scrollController) async {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void scrollDownOnTap(ScrollController scrollController) async {
    scrollController.animateTo(
      scrollController.position.extentTotal,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
