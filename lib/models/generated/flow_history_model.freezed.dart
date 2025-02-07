// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../flow_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FlowHistoryModel _$FlowHistoryModelFromJson(Map<String, dynamic> json) {
  return _FlowHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$FlowHistoryModel {
  String get id => throw _privateConstructorUsedError;
  String? get flowId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  int get flowTime => throw _privateConstructorUsedError; // 진행한 총 시간(초)
  int get round => throw _privateConstructorUsedError; // 몇 회차 진행했는지
  String get flowName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;

  /// Serializes this FlowHistoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlowHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlowHistoryModelCopyWith<FlowHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlowHistoryModelCopyWith<$Res> {
  factory $FlowHistoryModelCopyWith(
          FlowHistoryModel value, $Res Function(FlowHistoryModel) then) =
      _$FlowHistoryModelCopyWithImpl<$Res, FlowHistoryModel>;
  @useResult
  $Res call(
      {String id,
      String? flowId,
      String? userId,
      int flowTime,
      int round,
      String flowName,
      DateTime date,
      String notes});
}

/// @nodoc
class _$FlowHistoryModelCopyWithImpl<$Res, $Val extends FlowHistoryModel>
    implements $FlowHistoryModelCopyWith<$Res> {
  _$FlowHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlowHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? flowId = freezed,
    Object? userId = freezed,
    Object? flowTime = null,
    Object? round = null,
    Object? flowName = null,
    Object? date = null,
    Object? notes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$FlowHistoryModelImplCopyWith<$Res>
    implements $FlowHistoryModelCopyWith<$Res> {
  factory _$$FlowHistoryModelImplCopyWith(_$FlowHistoryModelImpl value,
          $Res Function(_$FlowHistoryModelImpl) then) =
      __$$FlowHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? flowId,
      String? userId,
      int flowTime,
      int round,
      String flowName,
      DateTime date,
      String notes});
}

/// @nodoc
class __$$FlowHistoryModelImplCopyWithImpl<$Res>
    extends _$FlowHistoryModelCopyWithImpl<$Res, _$FlowHistoryModelImpl>
    implements _$$FlowHistoryModelImplCopyWith<$Res> {
  __$$FlowHistoryModelImplCopyWithImpl(_$FlowHistoryModelImpl _value,
      $Res Function(_$FlowHistoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlowHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? flowId = freezed,
    Object? userId = freezed,
    Object? flowTime = null,
    Object? round = null,
    Object? flowName = null,
    Object? date = null,
    Object? notes = null,
  }) {
    return _then(_$FlowHistoryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$FlowHistoryModelImpl implements _FlowHistoryModel {
  const _$FlowHistoryModelImpl(
      {required this.id,
      this.flowId,
      this.userId,
      required this.flowTime,
      required this.round,
      required this.flowName,
      required this.date,
      this.notes = ""});

  factory _$FlowHistoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlowHistoryModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? flowId;
  @override
  final String? userId;
  @override
  final int flowTime;
// 진행한 총 시간(초)
  @override
  final int round;
// 몇 회차 진행했는지
  @override
  final String flowName;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final String notes;

  @override
  String toString() {
    return 'FlowHistoryModel(id: $id, flowId: $flowId, userId: $userId, flowTime: $flowTime, round: $round, flowName: $flowName, date: $date, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowHistoryModelImpl &&
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

  /// Create a copy of FlowHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlowHistoryModelImplCopyWith<_$FlowHistoryModelImpl> get copyWith =>
      __$$FlowHistoryModelImplCopyWithImpl<_$FlowHistoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlowHistoryModelImplToJson(
      this,
    );
  }
}

abstract class _FlowHistoryModel implements FlowHistoryModel {
  const factory _FlowHistoryModel(
      {required final String id,
      final String? flowId,
      final String? userId,
      required final int flowTime,
      required final int round,
      required final String flowName,
      required final DateTime date,
      final String notes}) = _$FlowHistoryModelImpl;

  factory _FlowHistoryModel.fromJson(Map<String, dynamic> json) =
      _$FlowHistoryModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get flowId;
  @override
  String? get userId;
  @override
  int get flowTime; // 진행한 총 시간(초)
  @override
  int get round; // 몇 회차 진행했는지
  @override
  String get flowName;
  @override
  DateTime get date;
  @override
  String get notes;

  /// Create a copy of FlowHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlowHistoryModelImplCopyWith<_$FlowHistoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
