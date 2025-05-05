import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/ui/features/likes_or_messages/messages/messages_wm.dart';
import 'package:petsder/ui/features/likes_or_messages/messages/widgets/message.dart';

class MessagesWidget extends ElementaryWidget<IMessagesWidgetModel> {
  const MessagesWidget({
    super.key
  }):super(defaultMessagesWidgetModelFactory);

  @override
  Widget build(IMessagesWidgetModel wm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index){
          return Message(
            name: 'name',
            lastMessage: 'lastMessage',
            photo: 'https://tiuhvynseevoicuqwteq.supabase.co/storage/v1/object/public/images/users/67inGecI5pVUXa1w6ZzTSxtco1y2/pets/67inGecI5pVUXa1w6ZzTSxtco1y2_lula/1746094202518',
            onTap: wm.onMessageTap,
          );
        }, 
      ),
    );
  }
}