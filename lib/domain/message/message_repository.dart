import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
import 'package:petsder/data/models/messages/chats_response/messages_item.dart';
import 'package:petsder/data/models/messages/chats_response_with_pet_info/chats_response_with_pet_info.dart';
import 'package:petsder/data/models/messages/message/message.dart';

class MessageRepository {
  Future<List<ChatsResponseWithPetInfo>> getChatsForPet(String petId) async {
    final firestore = FirebaseFirestore.instance;

    final querySnapshot =
        await firestore.collection('pets').doc(petId).collection('chats').orderBy('createdAt', descending: true).get();

    final petDoc = await firestore.collection('pets').doc(petId).get();

    final privateKeyPem = petDoc.data()?['privateKey'] as String?;

    if (privateKeyPem == null) {
      throw Exception();
    }

    final privateKey = RSAPrivateKey.fromPEM(privateKeyPem);

    final List<ChatsResponseWithPetInfo> results = [];

    for (final doc in querySnapshot.docs) {
      final chat = ChatsResponse.fromJson(doc.data());

      final encrypText = chat.lastMessage;

      String decryptedText = '';

      if(encrypText != null){
        decryptedText = privateKey.decrypt(encrypText);
      }

      final withPetSnapshot = await firestore.collection('pets').doc(chat.withPetId).get();
      final withPetData = withPetSnapshot.data();

      if (withPetData != null) {
        final petName = withPetData['name'] as String? ?? 'Неизвестно';
        final photos = (withPetData['photos'] as List?)?.cast<String>();

        results.add(
          ChatsResponseWithPetInfo(
            chat: decryptedText.isEmpty ? chat : chat.copyWith(lastMessage: decryptedText),
            withPetName: petName,
            withPetPhotoUrl: photos?.first ?? '',
          ),
        );
      }
    }

    return results;
  }

  Future<void> sendMessageWithChatId({
    required String chatId,
    required String fromPetId,
    required String text,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final chatRef = firestore.collection('chats').doc(chatId);
    final messageRef = chatRef.collection('messages').doc();
    final timestamp = FieldValue.serverTimestamp();

    final chatSnapshot = await chatRef.get();
    final participants = (chatSnapshot.data()?['participants'] as List).cast<String>();

    final toPetId = participants.firstWhere((id) => id != fromPetId);

    final fromPetDoc = await firestore.collection('pets').doc(fromPetId).get();
    final toPetDoc = await firestore.collection('pets').doc(toPetId).get();

    final fromPublicKeyPem = fromPetDoc.data()?['publicKey'] as String?;
    final toPublicKeyPem = toPetDoc.data()?['publicKey'] as String?;

    if (fromPublicKeyPem == null || toPublicKeyPem == null) {
      throw Exception();
    }

    final fromPublicKey = RSAPublicKey.fromPEM(fromPublicKeyPem);
    final toPublicKey = RSAPublicKey.fromPEM(fromPublicKeyPem);

    final encryptedForSender = fromPublicKey.encrypt(text);
    final encryptedForReceiver = toPublicKey.encrypt(text);

    final messageData = {
      'id': messageRef.id,
      'text': text,
      'fromPetId': fromPetId,
      'toPetId': toPetId,
      'timestamp': timestamp,
      'encryptedForFrom': encryptedForSender,
      'encryptedForTo': encryptedForReceiver,
    };

    final batch = firestore.batch();

    batch.set(messageRef, messageData);

    batch.update(chatRef, {
      'lastMessage': text,
      'lastMessageTime': timestamp,
    });

    final fromChatRef = firestore.collection('pets').doc(fromPetId).collection('chats').doc(chatId);
    final toChatRef = firestore.collection('pets').doc(toPetId).collection('chats').doc(chatId);

    batch.update(fromChatRef, {
      'lastMessage': encryptedForSender,
      'lastMessageTime': timestamp,
    });

    batch.update(toChatRef, {
      'lastMessage': encryptedForReceiver,
      'lastMessageTime': timestamp,
    });

    await batch.commit();
  }

  Future<List<MessageResponse>> getMessagesPage({
    required String chatId,
    required String currentPetId,
    int limit = 20,
    DocumentSnapshot? lastMessageDoc,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final messagesRef = firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    final query = lastMessageDoc != null ? messagesRef.startAfterDocument(lastMessageDoc) : messagesRef;
    final snapshot = await query.get();
    final docs = snapshot.docs;

    final petDoc = await firestore.collection('pets').doc(currentPetId).get();

    return docs.map((doc) {
      final data = doc.data();

      String decryptedText = '';
      try {
        final encrypted = currentPetId == data['fromPetId'] ? data['encryptedForFrom'] : data['encryptedForTo'];

        final privateKeyPem = petDoc.data()?['privateKey'] as String?;

        if (privateKeyPem == null) {
          throw Exception();
        }

        final privateKey = RSAPrivateKey.fromPEM(privateKeyPem);
        decryptedText = privateKey.decrypt(encrypted);
      } on Object {
        rethrow;
      }

      return MessageResponse(
        id: data['id'] as String,
        fromPetId: data['fromPetId'] as String,
        toPetId: data['toPetId'] as String,
        text: decryptedText,
        timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
      );
    }).toList();
  }
}
