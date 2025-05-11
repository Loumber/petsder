// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) {
  return _MessageResponse.fromJson(json);
}

/// @nodoc
mixin _$MessageResponse {
  String get id => throw _privateConstructorUsedError;
  String get fromPetId => throw _privateConstructorUsedError;
  String get toPetId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this MessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageResponseCopyWith<MessageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageResponseCopyWith<$Res> {
  factory $MessageResponseCopyWith(
          MessageResponse value, $Res Function(MessageResponse) then) =
      _$MessageResponseCopyWithImpl<$Res, MessageResponse>;
  @useResult
  $Res call(
      {String id,
      String fromPetId,
      String toPetId,
      String text,
      @TimestampConverter() DateTime? timestamp});
}

/// @nodoc
class _$MessageResponseCopyWithImpl<$Res, $Val extends MessageResponse>
    implements $MessageResponseCopyWith<$Res> {
  _$MessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromPetId = null,
    Object? toPetId = null,
    Object? text = null,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fromPetId: null == fromPetId
          ? _value.fromPetId
          : fromPetId // ignore: cast_nullable_to_non_nullable
              as String,
      toPetId: null == toPetId
          ? _value.toPetId
          : toPetId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageResponseImplCopyWith<$Res>
    implements $MessageResponseCopyWith<$Res> {
  factory _$$MessageResponseImplCopyWith(_$MessageResponseImpl value,
          $Res Function(_$MessageResponseImpl) then) =
      __$$MessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String fromPetId,
      String toPetId,
      String text,
      @TimestampConverter() DateTime? timestamp});
}

/// @nodoc
class __$$MessageResponseImplCopyWithImpl<$Res>
    extends _$MessageResponseCopyWithImpl<$Res, _$MessageResponseImpl>
    implements _$$MessageResponseImplCopyWith<$Res> {
  __$$MessageResponseImplCopyWithImpl(
      _$MessageResponseImpl _value, $Res Function(_$MessageResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromPetId = null,
    Object? toPetId = null,
    Object? text = null,
    Object? timestamp = freezed,
  }) {
    return _then(_$MessageResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fromPetId: null == fromPetId
          ? _value.fromPetId
          : fromPetId // ignore: cast_nullable_to_non_nullable
              as String,
      toPetId: null == toPetId
          ? _value.toPetId
          : toPetId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageResponseImpl implements _MessageResponse {
  _$MessageResponseImpl(
      {required this.id,
      required this.fromPetId,
      required this.toPetId,
      required this.text,
      @TimestampConverter() this.timestamp});

  factory _$MessageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String fromPetId;
  @override
  final String toPetId;
  @override
  final String text;
  @override
  @TimestampConverter()
  final DateTime? timestamp;

  @override
  String toString() {
    return 'MessageResponse(id: $id, fromPetId: $fromPetId, toPetId: $toPetId, text: $text, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromPetId, fromPetId) ||
                other.fromPetId == fromPetId) &&
            (identical(other.toPetId, toPetId) || other.toPetId == toPetId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, fromPetId, toPetId, text, timestamp);

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageResponseImplCopyWith<_$MessageResponseImpl> get copyWith =>
      __$$MessageResponseImplCopyWithImpl<_$MessageResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageResponseImplToJson(
      this,
    );
  }
}

abstract class _MessageResponse implements MessageResponse {
  factory _MessageResponse(
      {required final String id,
      required final String fromPetId,
      required final String toPetId,
      required final String text,
      @TimestampConverter() final DateTime? timestamp}) = _$MessageResponseImpl;

  factory _MessageResponse.fromJson(Map<String, dynamic> json) =
      _$MessageResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get fromPetId;
  @override
  String get toPetId;
  @override
  String get text;
  @override
  @TimestampConverter()
  DateTime? get timestamp;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageResponseImplCopyWith<_$MessageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
