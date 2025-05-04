import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/data/models/enums/like_or_message_state.dart';
import 'package:petsder/data/models/indexed_selector_item/indexed_selector_item.dart';
import 'package:petsder/ui/features/likes_or_messages/likes/likes_widgets.dart';
import 'package:petsder/ui/features/likes_or_messages/likes_or_messages_wm.dart';
import 'package:petsder/ui/features/likes_or_messages/widgets/indexed_selector.dart';

@RoutePage()
class LikesOrMessagesScreen extends ElementaryWidget<ILikesOrMessagesWidgetModel> {
  const LikesOrMessagesScreen({super.key}) : super(defaultLikesOrMessagesWidgetModelFactory);

  @override
  Widget build(ILikesOrMessagesWidgetModel wm) {
    return Scaffold(
        body: ValueListenableBuilder<LikeOrMessageState>(
            valueListenable: wm.likeOrMessageListenable,
            builder: (context, state, _) {
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IndexedSelector(
                        items: [
                          IndexedSelectorItem(
                            'лайки',
                            () => wm.onChangeLikeOrMessageState(LikeOrMessageState.like),
                            selected: state == LikeOrMessageState.like,
                          ),
                          IndexedSelectorItem(
                            'сообщения',
                            () => wm.onChangeLikeOrMessageState(LikeOrMessageState.message),
                            selected: state == LikeOrMessageState.message,
                          ),
                        ],
                      ),
                    ),
                    if (state == LikeOrMessageState.like) ...[
                      Expanded(child: const LikesWidgets()),
                    ] else
                      ...[]
                  ],
                ),
              );
            }));
  }
}
