import 'package:elementary/elementary.dart';
import 'package:petsder/data/models/messages/chats_response_with_pet_info/chats_response_with_pet_info.dart';
import 'package:petsder/domain/message/message_repository.dart';
abstract interface class IMessagesModel extends ElementaryModel{

  Future<List<ChatsResponseWithPetInfo>> getMessages(String petId);
}

class MessagesModel extends IMessagesModel {
  MessagesModel(
    this._messageRepository,
  );

  final MessageRepository _messageRepository;

  @override
  Future<List<ChatsResponseWithPetInfo>> getMessages(String petId) async {
    try {
      final res = await _messageRepository.getChatsForPet(petId);
      return res;
    } on Object {
      rethrow;
    }
  }
}