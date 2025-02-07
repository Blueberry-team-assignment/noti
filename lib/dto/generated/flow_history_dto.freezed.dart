// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../flow_history_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FlowHistoryDto _$FlowHistoryDtoFromJson(Map<String, dynamic> json) {
  return _FlowHistoryDto.fromJson(json);
}

/// @nodoc
mixin _$FlowHistoryDto {
  String? get id => throw _privateConstructorUsedError;
  String? get flowId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  int get flowTime => throw _privateConstructorUsedError; // 총 진행한 시간(초)
  int get round => throw _privateConstructorUsedError; // 몇 회차 진행했는지
  String get flowName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;

  /// Serializes this FlowHistoryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlowHistoryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlowHistoryDtoCopyWith<FlowHistoryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlowHistoryDtoCopyWith<$Res> {
  factory $FlowHistoryDtoCopyWith(
          FlowHistoryDto value, $Res Function(FlowHistoryDto) then) =
      _$FlowHistoryDtoCopyWithImpl<$Res, FlowHistoryDto>;
  @useResult
  $Res call(
      {String? id,
      String? flowId,
      String? userId,
      int flowTime,
      int round,
      String flowName,
      DateTime date,
      String notes});
}

/// @nodoc
class _$FlowHistoryDtoCopyWithImpl<$Res, $Val extends FlowHistoryDto>
    implements $FlowHistoryDtoCopyWith<$Res> {
  _$FlowHistoryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlowHistoryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? flowId = freezed,
    Object? userId = freezed,
    Object? flowTime = null,
    Object? round = null,
    Object? flowName = null,
    Object? date = null,
    Object? notes = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      flowId: freezed == flowId
          ? _value.flowId
          : flowId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      flowTime: null == flowTime
          ? _value.flowTime
          : flowTime // ignore: cast_nullable_to_non_nullable
              as int,
      round: null == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as int,
      flowName: null == flowName
          ? _value.flowName
          : flowName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlowHistoryDtoImplCopyWith<$Res>
    implements $FlowHistoryDtoCopyWith<$Res> {
  factory _$$FlowHistoryDtoImplCopyWith(_$FlowHistoryDtoImpl value,
          $Res Function(_$FlowHistoryDtoImpl) then) =
      __$$FlowHistoryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? flowId,
      String? userId,
      int flowTime,
      int round,
      String flowName,
      DateTime date,
      String notes});
}

/// @nodoc
class __$$FlowHistoryDtoImplCopyWithImpl<$Res>
    extends _$FlowHistoryDtoCopyWithImpl<$Res, _$FlowHistoryDtoImpl>
    implements _$$FlowHistoryDtoImplCopyWith<$Res> {
  __$$FlowHistoryDtoImplCopyWithImpl(
      _$FlowHistoryDtoImpl _value, $Res Function(_$FlowHistoryDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlowHistoryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? flowId = freezed,
    Object? userId = freezed,
    Object? flowTime = null,
    Object? round = null,
    Object? flowName = null,
    Object? date = null,
    Object? notes = null,
  }) {
    return _then(_$FlowHistoryDtoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      flowId: freezed == flowId
          ? _value.flowId
          : flowId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      flowTime: null == flowTime
          ? _value.flowTime
          : flowTime // ignore: cast_nullable_to_non_nullable
              as int,
      round: null == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as int,
      flowName: null == flowName
          ? _value.flowName
          : flowName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FlowHistoryDtoImpl implements _FlowHistoryDto {
  const _$FlowHistoryDtoImpl(
      {this.id,
      this.flowId,
      this.userId,
      this.flowTime = 0,
      this.round = 1,
      this.flowName = "",
      required this.date,
      this.notes = ""});

  factory _$FlowHistoryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlowHistoryDtoImplFromJson(json);

  @override
  final String? id;
  @override
  final String? flowId;
  @override
  final String? userId;
  @override
  @JsonKey()
  final int flowTime;
// 총 진행한 시간(초)
  @override
  @JsonKey()
  final int round;
// 몇 회차 진행했는지
  @override
  @JsonKey()
  final String flowName;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final String notes;

  @override
  String toString() {
    return 'FlowHistoryDto(id: $id, flowId: $flowId, userId: $userId, flowTime: $flowTime, round: $round, flowName: $flowName, date: $date, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowHistoryDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.flowId, flowId) || other.flowId == flowId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.flowTime, flowTime) ||
                other.flowTime == flowTime) &&
            (identical(other.round, round) || other.round == round) &&
            (identical(other.flowName, flowName) ||
                other.flowName == flowName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, flowId, userId, flowTime, round, flowName, date, notes);

  /// Create a copy of FlowHistoryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlowHistoryDtoImplCopyWith<_$FlowHistoryDtoImpl> get copyWith =>
      __$$FlowHistoryDtoImplCopyWithImpl<_$FlowHistoryDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlowHistoryDtoImplToJson(
      this,
    );
  }
}

abstract class _FlowHistoryDto implements FlowHistoryDto {
  const factory _FlowHistoryDto(
      {final String? id,
      final String? flowId,
      final String? userId,
      final int flowTime,
      final int round,
      final String flowName,
      required final DateTime date,
      final String notes}) = _$FlowHistoryDtoImpl;

  factory _FlowHistoryDto.fromJson(Map<String, dynamic> json) =
      _$FlowHistoryDtoImpl.fromJson;

  @override
  String? get id;
  @override
  String? get flowId;
  @override
  String? get userId;
  @override
  int get flowTime; // 총 진행한 시간(초)
  @override
  int get round; // 몇 회차 진행했는지
  @override
  String get flowName;
  @override
  DateTime get date;
  @override
  String get notes;

  /// Create a copy of FlowHistoryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlowHistoryDtoImplCopyWith<_$FlowHistoryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
