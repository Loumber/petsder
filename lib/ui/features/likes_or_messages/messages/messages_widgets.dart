import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:petsder/common/utils/logger/logger.dart';
import 'package:petsder/ui/features/app_lodaing_error.dart/app_loading_error_widget.dart';
import 'package:petsder/ui/features/likes_or_messages/messages/messages_wm.dart';
import 'package:petsder/ui/features/likes_or_messages/messages/widgets/message.dart';
import 'package:petsder/ui/widgets/common/app_loading.dart';

class MessagesWidget extends ElementaryWidget<IMessagesWidgetModel> {
  const MessagesWidget({super.key}) : super(defaultMessagesWidgetModelFactory);

  @override
  Widget build(IMessagesWidgetModel wm) {
    return EntityStateNotifierBuilder(
      listenableEntityState: wm.chatsListenable,
      errorBuilder: (context, e, data) => const AppLoadingErrorWidget(),
      loadingBuilder: (context, data) => const AppLoading(),
      builder: (context, chats) {
        if (chats == null) return const SizedBox();
        if (chats.isEmpty) {
          return Center(
              child: Text(
            'У Вас нет чатов',
            style: TextStyle(color: wm.theme.main.inputFieldLabelColor),
          ));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              AppLogger.info(chats[index].withPetPhotoUrl);
              return Message(
                name: chats[index].withPetName,
                lastMessage: chats[index].chat.lastMessage,
                photo: chats[index].withPetPhotoUrl,
                lastMessageTime: chats[index].lastMessageTime,
                onTap: () => wm.onMessageTap(index),
              );
            },
          ),
        );
      },
    );
  }
}
