import 'package:auto_route/annotations.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:petsder/ui/features/app_lodaing_error.dart/app_loading_error_widget.dart';
import 'package:petsder/ui/features/messaging/messaging_wm.dart';
import 'package:petsder/ui/features/messaging/widgets/chat_bubble.dart';
import 'package:petsder/ui/widgets/common/app_loading.dart';

@RoutePage()
class MessagingScreen extends ElementaryWidget<IMessagingWidgetModel> {
  const MessagingScreen({
    required this.id,
    required this.name,
    required this.photoUrl,
    super.key
  }) : super(defaultMessagingWidgetModelFactory);

  final String name;
  final String photoUrl;
  final String id;

  @override
  Widget build(IMessagingWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: wm.theme.main.onPrimary),
          onPressed: () => wm.onBackTap(),
        ),
        centerTitle: true,
        title: Text(
          name,
          style: TextStyle(fontSize: 20, color: wm.theme.main.onPrimary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 25,
              child: ClipOval(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image(
                    image: NetworkImage(
                      photoUrl
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: EntityStateNotifierBuilder(
                listenableEntityState: wm.messagesListenable,
                errorBuilder: (context, e, messages) => const AppLoadingErrorWidget(),
                loadingBuilder: (context, data) => const AppLoading(),
                builder: (context, messages) {
                  if (messages == null) return const SizedBox();
                  return ListView.builder(
                    reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          text: messages[index].text,
                          time: wm.messageTime(messages[index].timestamp),
                          isMe: wm.isMyMessage(index),
                        );
                      });
                }),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: TextField(
                          controller: wm.messageController,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                            fillColor: wm.theme.main.inputFieldBackgroundColor,
                            border: const OutlineInputBorder(),
                            labelText: 'Сообщение',
                          ))),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: wm.onSendTap,
                    elevation: 0,
                    backgroundColor: wm.theme.main.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.send_rounded,
                      color: wm.theme.main.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
