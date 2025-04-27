// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PetResponse _$PetResponseFromJson(Map<String, dynamic> json) {
  return _PetResponse.fromJson(json);
}

/// @nodoc
mixin _$PetResponse {
  String get id => throw _privateConstructorUsedError;
  String get age => throw _privateConstructorUsedError;
  String get breed => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get photos => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this PetResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PetResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PetResponseCopyWith<PetResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetResponseCopyWith<$Res> {
  factory $PetResponseCopyWith(
          PetResponse value, $Res Function(PetResponse) then) =
      _$PetResponseCopyWithImpl<$Res, PetResponse>;
  @useResult
  $Res call(
      {String id,
      String age,
      String breed,
      String description,
      String gender,
      String name,
      List<String> photos,
      String type});
}

/// @nodoc
class _$PetResponseCopyWithImpl<$Res, $Val extends PetResponse>
    implements $PetResponseCopyWith<$Res> {
  _$PetResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PetResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? age = null,
    Object? breed = null,
    Object? description = null,
    Object? gender = null,
    Object? name = null,
    Object? photos = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
      breed: null == breed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PetResponseImplCopyWith<$Res>
    implements $PetResponseCopyWith<$Res> {
  factory _$$PetResponseImplCopyWith(
          _$PetResponseImpl value, $Res Function(_$PetResponseImpl) then) =
      __$$PetResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String age,
      String breed,
      String description,
      String gender,
      String name,
      List<String> photos,
      String type});
}

/// @nodoc
class __$$PetResponseImplCopyWithImpl<$Res>
    extends _$PetResponseCopyWithImpl<$Res, _$PetResponseImpl>
    implements _$$PetResponseImplCopyWith<$Res> {
  __$$PetResponseImplCopyWithImpl(
      _$PetResponseImpl _value, $Res Function(_$PetResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PetResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? age = null,
    Object? breed = null,
    Object? description = null,
    Object? gender = null,
    Object? name = null,
    Object? photos = null,
    Object? type = null,
  }) {
    return _then(_$PetResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
      breed: null == breed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PetResponseImpl implements _PetResponse {
  _$PetResponseImpl(
      {required this.id,
      required this.age,
      required this.breed,
      required this.description,
      required this.gender,
      required this.name,
      required final List<String> photos,
      required this.type})
      : _photos = photos;

  factory _$PetResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String age;
  @override
  final String breed;
  @override
  final String description;
  @override
  final String gender;
  @override
  final String name;
  final List<String> _photos;
  @override
  List<String> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  final String type;

  @override
  String toString() {
    return 'PetResponse(id: $id, age: $age, breed: $breed, description: $description, gender: $gender, name: $name, photos: $photos, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.breed, breed) || other.breed == breed) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, age, breed, description,
      gender, name, const DeepCollectionEquality().hash(_photos), type);

  /// Create a copy of PetResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PetResponseImplCopyWith<_$PetResponseImpl> get copyWith =>
      __$$PetResponseImplCopyWithImpl<_$PetResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetResponseImplToJson(
      this,
    );
  }
}

abstract class _PetResponse implements PetResponse {
  factory _PetResponse(
      {required final String id,
      required final String age,
      required final String breed,
      required final String description,
      required final String gender,
      required final String name,
      required final List<String> photos,
      required final String type}) = _$PetResponseImpl;

  factory _PetResponse.fromJson(Map<String, dynamic> json) =
      _$PetResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get age;
  @override
  String get breed;
  @override
  String get description;
  @override
  String get gender;
  @override
  String get name;
  @override
  List<String> get photos;
  @override
  String get type;

  /// Create a copy of PetResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PetResponseImplCopyWith<_$PetResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
