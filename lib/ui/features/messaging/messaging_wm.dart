import 'package:auto_route/auto_route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:intl/intl.dart';
import 'package:petsder/common/utils/di/scopes/global/global_scope.dart';
import 'package:petsder/common/utils/di/scopes/user_info/user_info_scope.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/data/models/messages/message/message.dart';
import 'package:petsder/ui/features/messaging/messaging_model.dart';
import 'package:petsder/ui/features/messaging/messaging_widget.dart';
import 'package:petsder/ui/theme/theme.dart';

abstract interface class IMessagingWidgetModel implements IWidgetModel {
  EntityValueListenable<List<MessageResponse>> get messagesListenable;

  void onBackTap();

  void onSendTap();

  bool isMyMessage(int index);

  String messageTime(DateTime? timestamp);

  TextEditingController get messageController;

  AppThemeData get theme;

  MediaQueryData get mediaQuaery;
}

MessagingWidgetModel defaultMessagingWidgetModelFactory(BuildContext context) {
  return MessagingWidgetModel(MessagingModel(context.global.messageRepository, context.global.overlayBloc));
}

class MessagingWidgetModel extends WidgetModel<MessagingScreen, IMessagingModel> implements IMessagingWidgetModel {
  MessagingWidgetModel(MessagingModel super.model);

  final _messagesEntity = EntityStateNotifier<List<MessageResponse>>();

  @override
  EntityValueListenable<List<MessageResponse>> get messagesListenable => _messagesEntity;

  final _messageController = TextEditingController();

  @override
  TextEditingController get messageController => _messageController;

  @override
  void onBackTap() {
    context.router.maybePop();
  }

  @override
  String messageTime(DateTime? timestamp) {
    if(timestamp == null) return '';
    final now = DateTime.now();
    final isToday = timestamp.day == now.day && timestamp.month == now.month && timestamp.year == now.year;

    if (isToday) {
      return DateFormat('HH:mm').format(timestamp);
    } else {
      return DateFormat('dd.MM').format(timestamp);
    }
    
  }

  @override
  Future<void> onSendTap() async {
    try {
      await model.sendMessage(
          chatId: widget.id,
          fromPetId: context.user.userController.currentPetNotifier.value!.id,
          text: _messageController.text);
      _messageController.clear();
      // ignore: use_build_context_synchronously
      final messages = await model.getMessages(widget.id, context.user.userController.currentPetNotifier.value!.id ,null);
      _messagesEntity.content(messages);


    } on Object {
      model.showOverlayNotification(const Text('Не удалось отправить сообщение'));
    }
  }

  @override
  bool isMyMessage(int index) {
    if (_messagesEntity.value.data == null) return false;

    return _messagesEntity.value.data![index].fromPetId == context.user.userController.currentPetNotifier.value!.id;
    
  }

  @override
  void initWidgetModel() {
    _initAsync();

    super.initWidgetModel();
  }

  Future<void> _initAsync() async {
    try {
      _messagesEntity.loading();

      // ignore: use_build_context_synchronously
      if (context.user.userController.currentPetNotifier.value != null) {
        final messages = await model.getMessages(widget.id, context.user.userController.currentPetNotifier.value!.id ,null);

        _messagesEntity.content(messages);
      }
    } on Object {
      _messagesEntity.error();
    }
  }

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;

}
