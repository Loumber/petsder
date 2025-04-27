import 'package:freezed_annotation/freezed_annotation.dart';

part 'pet_response.freezed.dart';
part 'pet_response.g.dart';

@freezed
class PetResponse with _$PetResponse {
  factory PetResponse({
    required String id,
    required String age,
    required String breed,
    required String description,
    required String gender,
    required String name,
    required List<String> photos,
    required String type,
  }) = _PetResponse;

  factory PetResponse.fromJson(Map<String, dynamic> json) => _$PetResponseFromJson(json);
}