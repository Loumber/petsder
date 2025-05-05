import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/common/utils/navigation/app_router.dart';
import 'package:petsder/ui/features/likes_or_messages/messages/messages_model.dart';
import 'package:petsder/ui/features/likes_or_messages/messages/messages_widgets.dart';
import 'package:petsder/ui/theme/theme.dart';

abstract interface class IMessagesWidgetModel implements IWidgetModel {
  
  Future<void> onMessageTap();
  
  AppThemeData get theme;

  MediaQueryData get mediaQuaery;
}

MessagesWidgetModel defaultMessagesWidgetModelFactory(BuildContext context) {
  return MessagesWidgetModel(MessagesModel());
}

class MessagesWidgetModel extends WidgetModel<MessagesWidget, IMessagesModel> implements IMessagesWidgetModel {
  MessagesWidgetModel(MessagesModel super.model);

  @override
  Future<void> onMessageTap() async {
    await context.router.push(const MessagingRoute());
    
  }

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}
