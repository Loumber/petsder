// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animal_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnimalResponse _$AnimalResponseFromJson(Map<String, dynamic> json) {
  return _AnimalResponse.fromJson(json);
}

/// @nodoc
mixin _$AnimalResponse {
  String get type => throw _privateConstructorUsedError;
  List<String> get breed => throw _privateConstructorUsedError;

  /// Serializes this AnimalResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnimalResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnimalResponseCopyWith<AnimalResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnimalResponseCopyWith<$Res> {
  factory $AnimalResponseCopyWith(
          AnimalResponse value, $Res Function(AnimalResponse) then) =
      _$AnimalResponseCopyWithImpl<$Res, AnimalResponse>;
  @useResult
  $Res call({String type, List<String> breed});
}

/// @nodoc
class _$AnimalResponseCopyWithImpl<$Res, $Val extends AnimalResponse>
    implements $AnimalResponseCopyWith<$Res> {
  _$AnimalResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnimalResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? breed = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      breed: null == breed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnimalResponseImplCopyWith<$Res>
    implements $AnimalResponseCopyWith<$Res> {
  factory _$$AnimalResponseImplCopyWith(_$AnimalResponseImpl value,
          $Res Function(_$AnimalResponseImpl) then) =
      __$$AnimalResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, List<String> breed});
}

/// @nodoc
class __$$AnimalResponseImplCopyWithImpl<$Res>
    extends _$AnimalResponseCopyWithImpl<$Res, _$AnimalResponseImpl>
    implements _$$AnimalResponseImplCopyWith<$Res> {
  __$$AnimalResponseImplCopyWithImpl(
      _$AnimalResponseImpl _value, $Res Function(_$AnimalResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnimalResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? breed = null,
  }) {
    return _then(_$AnimalResponseImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      breed: null == breed
          ? _value._breed
          : breed // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnimalResponseImpl implements _AnimalResponse {
  _$AnimalResponseImpl({required this.type, required final List<String> breed})
      : _breed = breed;

  factory _$AnimalResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnimalResponseImplFromJson(json);

  @override
  final String type;
  final List<String> _breed;
  @override
  List<String> get breed {
    if (_breed is EqualUnmodifiableListView) return _breed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_breed);
  }

  @override
  String toString() {
    return 'AnimalResponse(type: $type, breed: $breed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimalResponseImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._breed, _breed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_breed));

  /// Create a copy of AnimalResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnimalResponseImplCopyWith<_$AnimalResponseImpl> get copyWith =>
      __$$AnimalResponseImplCopyWithImpl<_$AnimalResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnimalResponseImplToJson(
      this,
    );
  }
}

abstract class _AnimalResponse implements AnimalResponse {
  factory _AnimalResponse(
      {required final String type,
      required final List<String> breed}) = _$AnimalResponseImpl;

  factory _AnimalResponse.fromJson(Map<String, dynamic> json) =
      _$AnimalResponseImpl.fromJson;

  @override
  String get type;
  @override
  List<String> get breed;

  /// Create a copy of AnimalResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnimalResponseImplCopyWith<_$AnimalResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
