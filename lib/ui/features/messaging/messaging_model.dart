import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/data/models/messages/message/message.dart';
import 'package:petsder/domain/message/message_repository.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc.dart';
import 'package:petsder/domain/overlay_bloc/overlay_bloc_events.dart';

abstract interface class IMessagingModel extends ElementaryModel {

  Future<void> sendMessage({required String chatId, required String fromPetId, required String text });

  Future<List<MessageResponse>> getMessages(String chatId, String currentPetId,DocumentSnapshot<Object?>? lastMessageDoc);

  void showOverlayNotification(Widget widget);

}

class MessagingModel extends IMessagingModel {
  MessagingModel(
    this._messageRepository,
    this._overlayBloc
  );

  final OverlayBloc _overlayBloc;

  final MessageRepository _messageRepository;

  @override
  Future<List<MessageResponse>> getMessages(String chatId, String currentPetId,DocumentSnapshot<Object?>? lastMessageDoc) async {
    try {
      final res = await _messageRepository.getMessagesPage(chatId: chatId, currentPetId: currentPetId ,lastMessageDoc:lastMessageDoc );
      return res;
    } on Object {
      rethrow;
    }    
  }

  @override
  Future<void> sendMessage({required String chatId, required String fromPetId, required String text }) async {
    try {
      _messageRepository.sendMessageWithChatId(chatId: chatId, fromPetId: fromPetId, text: text);
    } on Object {
      rethrow;
    }
  }
  
  @override 
  void showOverlayNotification(Widget widget)  =>
    _overlayBloc.add(OverlayBlocShowEvent(notificationWidget: widget, duration: const Duration(seconds: 3)));
  
}
