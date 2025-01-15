// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PushNotificationModel _$PushNotificationModelFromJson(
    Map<String, dynamic> json) {
  return _PushNotificationModel.fromJson(json);
}

/// @nodoc
mixin _$PushNotificationModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  DateTime get pushDate => throw _privateConstructorUsedError; // 알림 발송 시각
  String get flowId => throw _privateConstructorUsedError;

  /// Serializes this PushNotificationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PushNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PushNotificationModelCopyWith<PushNotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationModelCopyWith<$Res> {
  factory $PushNotificationModelCopyWith(PushNotificationModel value,
          $Res Function(PushNotificationModel) then) =
      _$PushNotificationModelCopyWithImpl<$Res, PushNotificationModel>;
  @useResult
  $Res call(
      {String id, String title, String desc, DateTime pushDate, String flowId});
}

/// @nodoc
class _$PushNotificationModelCopyWithImpl<$Res,
        $Val extends PushNotificationModel>
    implements $PushNotificationModelCopyWith<$Res> {
  _$PushNotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PushNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? desc = null,
    Object? pushDate = null,
    Object? flowId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      pushDate: null == pushDate
          ? _value.pushDate
          : pushDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      flowId: null == flowId
          ? _value.flowId
          : flowId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PushNotificationModelImplCopyWith<$Res>
    implements $PushNotificationModelCopyWith<$Res> {
  factory _$$PushNotificationModelImplCopyWith(
          _$PushNotificationModelImpl value,
          $Res Function(_$PushNotificationModelImpl) then) =
      __$$PushNotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String title, String desc, DateTime pushDate, String flowId});
}

/// @nodoc
class __$$PushNotificationModelImplCopyWithImpl<$Res>
    extends _$PushNotificationModelCopyWithImpl<$Res,
        _$PushNotificationModelImpl>
    implements _$$PushNotificationModelImplCopyWith<$Res> {
  __$$PushNotificationModelImplCopyWithImpl(_$PushNotificationModelImpl _value,
      $Res Function(_$PushNotificationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? desc = null,
    Object? pushDate = null,
    Object? flowId = null,
  }) {
    return _then(_$PushNotificationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      pushDate: null == pushDate
          ? _value.pushDate
          : pushDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      flowId: null == flowId
          ? _value.flowId
          : flowId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PushNotificationModelImpl implements _PushNotificationModel {
  const _$PushNotificationModelImpl(
      {required this.id,
      required this.title,
      this.desc = "",
      required this.pushDate,
      required this.flowId});

  factory _$PushNotificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PushNotificationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final String desc;
  @override
  final DateTime pushDate;
// 알림 발송 시각
  @override
  final String flowId;

  @override
  String toString() {
    return 'PushNotificationModel(id: $id, title: $title, desc: $desc, pushDate: $pushDate, flowId: $flowId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushNotificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.pushDate, pushDate) ||
                other.pushDate == pushDate) &&
            (identical(other.flowId, flowId) || other.flowId == flowId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, desc, pushDate, flowId);

  /// Create a copy of PushNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushNotificationModelImplCopyWith<_$PushNotificationModelImpl>
      get copyWith => __$$PushNotificationModelImplCopyWithImpl<
          _$PushNotificationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushNotificationModelImplToJson(
      this,
    );
  }
}

abstract class _PushNotificationModel implements PushNotificationModel {
  const factory _PushNotificationModel(
      {required final String id,
      required final String title,
      final String desc,
      required final DateTime pushDate,
      required final String flowId}) = _$PushNotificationModelImpl;

  factory _PushNotificationModel.fromJson(Map<String, dynamic> json) =
      _$PushNotificationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get desc;
  @override
  DateTime get pushDate; // 알림 발송 시각
  @override
  String get flowId;

  /// Create a copy of PushNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushNotificationModelImplCopyWith<_$PushNotificationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
