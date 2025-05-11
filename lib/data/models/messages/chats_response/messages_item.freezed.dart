// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatsResponse _$ChatsResponseFromJson(Map<String, dynamic> json) {
  return _ChatsResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatsResponse {
  String get withPetId => throw _privateConstructorUsedError;
  String get chatId => throw _privateConstructorUsedError;
  String? get lastMessage => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastMessageTime => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChatsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatsResponseCopyWith<ChatsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatsResponseCopyWith<$Res> {
  factory $ChatsResponseCopyWith(
          ChatsResponse value, $Res Function(ChatsResponse) then) =
      _$ChatsResponseCopyWithImpl<$Res, ChatsResponse>;
  @useResult
  $Res call(
      {String withPetId,
      String chatId,
      String? lastMessage,
      @TimestampConverter() DateTime? lastMessageTime,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$ChatsResponseCopyWithImpl<$Res, $Val extends ChatsResponse>
    implements $ChatsResponseCopyWith<$Res> {
  _$ChatsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? withPetId = null,
    Object? chatId = null,
    Object? lastMessage = freezed,
    Object? lastMessageTime = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      withPetId: null == withPetId
          ? _value.withPetId
          : withPetId // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageTime: freezed == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatsResponseImplCopyWith<$Res>
    implements $ChatsResponseCopyWith<$Res> {
  factory _$$ChatsResponseImplCopyWith(
          _$ChatsResponseImpl value, $Res Function(_$ChatsResponseImpl) then) =
      __$$ChatsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String withPetId,
      String chatId,
      String? lastMessage,
      @TimestampConverter() DateTime? lastMessageTime,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$ChatsResponseImplCopyWithImpl<$Res>
    extends _$ChatsResponseCopyWithImpl<$Res, _$ChatsResponseImpl>
    implements _$$ChatsResponseImplCopyWith<$Res> {
  __$$ChatsResponseImplCopyWithImpl(
      _$ChatsResponseImpl _value, $Res Function(_$ChatsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? withPetId = null,
    Object? chatId = null,
    Object? lastMessage = freezed,
    Object? lastMessageTime = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ChatsResponseImpl(
      withPetId: null == withPetId
          ? _value.withPetId
          : withPetId // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageTime: freezed == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatsResponseImpl implements _ChatsResponse {
  _$ChatsResponseImpl(
      {required this.withPetId,
      required this.chatId,
      required this.lastMessage,
      @TimestampConverter() this.lastMessageTime,
      @TimestampConverter() this.createdAt});

  factory _$ChatsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatsResponseImplFromJson(json);

  @override
  final String withPetId;
  @override
  final String chatId;
  @override
  final String? lastMessage;
  @override
  @TimestampConverter()
  final DateTime? lastMessageTime;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ChatsResponse(withPetId: $withPetId, chatId: $chatId, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatsResponseImpl &&
            (identical(other.withPetId, withPetId) ||
                other.withPetId == withPetId) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, withPetId, chatId, lastMessage, lastMessageTime, createdAt);

  /// Create a copy of ChatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatsResponseImplCopyWith<_$ChatsResponseImpl> get copyWith =>
      __$$ChatsResponseImplCopyWithImpl<_$ChatsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatsResponseImplToJson(
      this,
    );
  }
}

abstract class _ChatsResponse implements ChatsResponse {
  factory _ChatsResponse(
      {required final String withPetId,
      required final String chatId,
      required final String? lastMessage,
      @TimestampConverter() final DateTime? lastMessageTime,
      @TimestampConverter() final DateTime? createdAt}) = _$ChatsResponseImpl;

  factory _ChatsResponse.fromJson(Map<String, dynamic> json) =
      _$ChatsResponseImpl.fromJson;

  @override
  String get withPetId;
  @override
  String get chatId;
  @override
  String? get lastMessage;
  @override
  @TimestampConverter()
  DateTime? get lastMessageTime;
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// Create a copy of ChatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatsResponseImplCopyWith<_$ChatsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
