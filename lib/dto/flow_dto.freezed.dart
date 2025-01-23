// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flow_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FlowDto _$FlowDtoFromJson(Map<String, dynamic> json) {
  return _FlowDto.fromJson(json);
}

/// @nodoc
mixin _$FlowDto {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  Duration? get duration => throw _privateConstructorUsedError;
  String? get ratio => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;

  /// Serializes this FlowDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlowDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlowDtoCopyWith<FlowDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlowDtoCopyWith<$Res> {
  factory $FlowDtoCopyWith(FlowDto value, $Res Function(FlowDto) then) =
      _$FlowDtoCopyWithImpl<$Res, FlowDto>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? category,
      Duration? duration,
      String? ratio,
      String? desc});
}

/// @nodoc
class _$FlowDtoCopyWithImpl<$Res, $Val extends FlowDto>
    implements $FlowDtoCopyWith<$Res> {
  _$FlowDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlowDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? category = freezed,
    Object? duration = freezed,
    Object? ratio = freezed,
    Object? desc = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      ratio: freezed == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlowDtoImplCopyWith<$Res> implements $FlowDtoCopyWith<$Res> {
  factory _$$FlowDtoImplCopyWith(
          _$FlowDtoImpl value, $Res Function(_$FlowDtoImpl) then) =
      __$$FlowDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? category,
      Duration? duration,
      String? ratio,
      String? desc});
}

/// @nodoc
class __$$FlowDtoImplCopyWithImpl<$Res>
    extends _$FlowDtoCopyWithImpl<$Res, _$FlowDtoImpl>
    implements _$$FlowDtoImplCopyWith<$Res> {
  __$$FlowDtoImplCopyWithImpl(
      _$FlowDtoImpl _value, $Res Function(_$FlowDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlowDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? category = freezed,
    Object? duration = freezed,
    Object? ratio = freezed,
    Object? desc = freezed,
  }) {
    return _then(_$FlowDtoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      ratio: freezed == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FlowDtoImpl implements _FlowDto {
  const _$FlowDtoImpl(
      {this.id,
      this.name,
      this.category,
      this.duration,
      this.ratio,
      this.desc});

  factory _$FlowDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlowDtoImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? category;
  @override
  final Duration? duration;
  @override
  final String? ratio;
  @override
  final String? desc;

  @override
  String toString() {
    return 'FlowDto(id: $id, name: $name, category: $category, duration: $duration, ratio: $ratio, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.ratio, ratio) || other.ratio == ratio) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, category, duration, ratio, desc);

  /// Create a copy of FlowDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlowDtoImplCopyWith<_$FlowDtoImpl> get copyWith =>
      __$$FlowDtoImplCopyWithImpl<_$FlowDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlowDtoImplToJson(
      this,
    );
  }
}

abstract class _FlowDto implements FlowDto {
  const factory _FlowDto(
      {final String? id,
      final String? name,
      final String? category,
      final Duration? duration,
      final String? ratio,
      final String? desc}) = _$FlowDtoImpl;

  factory _FlowDto.fromJson(Map<String, dynamic> json) = _$FlowDtoImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get category;
  @override
  Duration? get duration;
  @override
  String? get ratio;
  @override
  String? get desc;

  /// Create a copy of FlowDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlowDtoImplCopyWith<_$FlowDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
