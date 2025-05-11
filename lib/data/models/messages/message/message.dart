import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petsder/data/converters/timestamp_converter.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class MessageResponse with _$MessageResponse {
  factory MessageResponse({
    required String id,
    required String fromPetId,
    required String toPetId,
    required String text,
    @TimestampConverter() DateTime? timestamp,
  }) = _MessageResponse;

  factory MessageResponse.fromJson(Map<String, dynamic> json) => _$MessageResponseFromJson(json);
}
