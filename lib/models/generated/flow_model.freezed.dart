// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../flow_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FlowModel _$FlowModelFromJson(Map<String, dynamic> json) {
  return _FlowModel.fromJson(json);
}

/// @nodoc
mixin _$FlowModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  Duration? get duration => throw _privateConstructorUsedError; // 1 플로우의 총 시간
  Duration get focusTime => throw _privateConstructorUsedError;
  Duration get restTime => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;

  /// Serializes this FlowModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlowModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlowModelCopyWith<FlowModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlowModelCopyWith<$Res> {
  factory $FlowModelCopyWith(FlowModel value, $Res Function(FlowModel) then) =
      _$FlowModelCopyWithImpl<$Res, FlowModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? category,
      Duration? duration,
      Duration focusTime,
      Duration restTime,
      String desc});
}

/// @nodoc
class _$FlowModelCopyWithImpl<$Res, $Val extends FlowModel>
    implements $FlowModelCopyWith<$Res> {
  _$FlowModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlowModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = freezed,
    Object? duration = freezed,
    Object? focusTime = null,
    Object? restTime = null,
    Object? desc = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      focusTime: null == focusTime
          ? _value.focusTime
          : focusTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      restTime: null == restTime
          ? _value.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlowModelImplCopyWith<$Res>
    implements $FlowModelCopyWith<$Res> {
  factory _$$FlowModelImplCopyWith(
          _$FlowModelImpl value, $Res Function(_$FlowModelImpl) then) =
      __$$FlowModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? category,
      Duration? duration,
      Duration focusTime,
      Duration restTime,
      String desc});
}

/// @nodoc
class __$$FlowModelImplCopyWithImpl<$Res>
    extends _$FlowModelCopyWithImpl<$Res, _$FlowModelImpl>
    implements _$$FlowModelImplCopyWith<$Res> {
  __$$FlowModelImplCopyWithImpl(
      _$FlowModelImpl _value, $Res Function(_$FlowModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlowModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = freezed,
    Object? duration = freezed,
    Object? focusTime = null,
    Object? restTime = null,
    Object? desc = null,
  }) {
    return _then(_$FlowModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      focusTime: null == focusTime
          ? _value.focusTime
          : focusTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      restTime: null == restTime
          ? _value.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FlowModelImpl implements _FlowModel {
  const _$FlowModelImpl(
      {required this.id,
      required this.name,
      this.category,
      this.duration,
      required this.focusTime,
      required this.restTime,
      this.desc = ""});

  factory _$FlowModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlowModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? category;
  @override
  final Duration? duration;
// 1 플로우의 총 시간
  @override
  final Duration focusTime;
  @override
  final Duration restTime;
  @override
  @JsonKey()
  final String desc;

  @override
  String toString() {
    return 'FlowModel(id: $id, name: $name, category: $category, duration: $duration, focusTime: $focusTime, restTime: $restTime, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.focusTime, focusTime) ||
                other.focusTime == focusTime) &&
            (identical(other.restTime, restTime) ||
                other.restTime == restTime) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, category, duration, focusTime, restTime, desc);

  /// Create a copy of FlowModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlowModelImplCopyWith<_$FlowModelImpl> get copyWith =>
      __$$FlowModelImplCopyWithImpl<_$FlowModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlowModelImplToJson(
      this,
    );
  }
}

abstract class _FlowModel implements FlowModel {
  const factory _FlowModel(
      {required final String id,
      required final String name,
      final String? category,
      final Duration? duration,
      required final Duration focusTime,
      required final Duration restTime,
      final String desc}) = _$FlowModelImpl;

  factory _FlowModel.fromJson(Map<String, dynamic> json) =
      _$FlowModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get category;
  @override
  Duration? get duration; // 1 플로우의 총 시간
  @override
  Duration get focusTime;
  @override
  Duration get restTime;
  @override
  String get desc;

  /// Create a copy of FlowModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlowModelImplCopyWith<_$FlowModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
