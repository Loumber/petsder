import 'package:auto_route/auto_route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';
import 'package:petsder/data/models/messages/chats_response_with_pet_info/chats_response_with_pet_info.dart';
import 'package:petsder/ui/features/likes_or_messages/messages/messages_model.dart';
import 'package:petsder/ui/features/likes_or_messages/messages/messages_widgets.dart';
import 'package:petsder/ui/theme/theme.dart';

abstract interface class IMessagesWidgetModel implements IWidgetModel {
  EntityValueListenable<List<ChatsResponseWithPetInfo>> get chatsListenable;

  Future<void> onMessageTap(int index);

  AppThemeData get theme;

  MediaQueryData get mediaQuaery;
}

MessagesWidgetModel defaultMessagesWidgetModelFactory(BuildContext context) {
  return MessagesWidgetModel(MessagesModel(context.global.messageRepository));
}

class MessagesWidgetModel extends WidgetModel<MessagesWidget, IMessagesModel> implements IMessagesWidgetModel {
  MessagesWidgetModel(MessagesModel super.model);

  final _chatsEntity = EntityStateNotifier<List<ChatsResponseWithPetInfo>>();

  @override
  EntityValueListenable<List<ChatsResponseWithPetInfo>> get chatsListenable => _chatsEntity;

  @override
  void initWidgetModel() {
    _initAsync();

    super.initWidgetModel();
  }

  Future<void> _initAsync() async {
    try {
      _chatsEntity.loading();

      if (context.user.userController.currentPetNotifier.value != null) {
        final chats = await model.getMessages(context.user.userController.currentPetNotifier.value!.id);
        _chatsEntity.content(chats);
      }
    } on Exception {
      _chatsEntity.error();
    }
  }

  @override
  Future<void> onMessageTap(int index) async {
    await context.router.push(
      MessagingRoute(
        id: _chatsEntity.value.data![index].chat.chatId,
        name: _chatsEntity.value.data![index].withPetName,
        photoUrl: _chatsEntity.value.data![index].withPetPhotoUrl,
      )
    );
  }

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}
