import 'package:freezed_annotation/freezed_annotation.dart';

part 'animal_response.freezed.dart';
part 'animal_response.g.dart';

@freezed
class AnimalResponse with _$AnimalResponse {
  factory AnimalResponse({
    required String type,
    required List<String> breed,
  }) = _AnimalResponse;

  factory AnimalResponse.fromJson(Map<String, dynamic> json) => _$AnimalResponseFromJson(json);
}
