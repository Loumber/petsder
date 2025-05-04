import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:petsder/common/utils/extensions/widget_model_extensions.dart';
import 'package:petsder/data/models/enums/like_or_message_state.dart';
import 'package:petsder/ui/features/likes_or_messages/likes_or_messages_model.dart';
import 'package:petsder/ui/features/likes_or_messages/likes_or_messages_widget.dart';
import 'package:petsder/ui/theme/theme.dart';

abstract interface class ILikesOrMessagesWidgetModel implements IWidgetModel {
  ValueNotifier<LikeOrMessageState> get likeOrMessageListenable;

  void onChangeLikeOrMessageState(LikeOrMessageState state);
  
  AppThemeData get theme;

  MediaQueryData get mediaQuaery;
}

LikesOrMessagesWidgetModel defaultLikesOrMessagesWidgetModelFactory(BuildContext context) {
  return LikesOrMessagesWidgetModel(LikesOrMessagesModel());
}

class LikesOrMessagesWidgetModel extends WidgetModel<LikesOrMessagesScreen, ILikesOrMessagesModel> implements ILikesOrMessagesWidgetModel {
  LikesOrMessagesWidgetModel(LikesOrMessagesModel super.model);

  final _likeOrMessageEntity = ValueNotifier<LikeOrMessageState>(LikeOrMessageState.like);

  @override
  void onChangeLikeOrMessageState(LikeOrMessageState state){
    if (state == LikeOrMessageState.like) {
      _likeOrMessageEntity.value = LikeOrMessageState.like;
    } else {
      _likeOrMessageEntity.value = LikeOrMessageState.message;
    }
  }

  @override
  ValueNotifier<LikeOrMessageState> get likeOrMessageListenable => _likeOrMessageEntity;

  @override
  MediaQueryData get mediaQuaery => wmMediaQuery;

  @override
  AppThemeData get theme => wmTheme;
}
