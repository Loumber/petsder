import 'package:intl/intl.dart';
import 'package:petsder/data/models/messages/chats_response/messages_item.dart';

class ChatsResponseWithPetInfo {
  final ChatsResponse chat;
  final String withPetName;
  final String withPetPhotoUrl;

  ChatsResponseWithPetInfo({
    required this.chat,
    required this.withPetName,
    required this.withPetPhotoUrl,
  });

  String get lastMessageTime {
    final dateTime = chat.lastMessageTime ?? chat.createdAt;
    if (dateTime == null) return '';
    final now = DateTime.now();
    final isToday = dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year;

    if (isToday) {
      return DateFormat('HH:mm').format(dateTime);
    } else {
      return DateFormat('dd.MM').format(dateTime);
    }
  }
}
