import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petsder/data/converters/timestamp_converter.dart';

part 'messages_item.freezed.dart';
part 'messages_item.g.dart';

@freezed
class ChatsResponse with _$ChatsResponse {
  factory ChatsResponse({
    required String withPetId,
    required String chatId,
    required String? lastMessage,
    @TimestampConverter() DateTime? lastMessageTime,
    @TimestampConverter() DateTime? createdAt,
  }) = _ChatsResponse;

  factory ChatsResponse.fromJson(Map<String, dynamic> json) => _$ChatsResponseFromJson(json);
}
