import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/ui/features/messaging/messaging_model.dart';
import 'package:petsder/ui/features/messaging/messaging_widget.dart';
import 'package:petsder/ui/theme/theme.dart';

abstract interface class IMessagingWidgetModel implements IWidgetModel {
  
  AppThemeData get theme;

  MediaQueryData get mediaQuaery;
}

MessagingWidgetModel defaultMessagingWidgetModelFactory(BuildContext context) {
  return MessagingWidgetModel(MessagingModel());
}

class MessagingWidgetModel extends WidgetModel<MessagingScreen, IMessagingModel> implements IMessagingWidgetModel {
  MessagingWidgetModel(MessagingModel super.model);


  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}
