// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PushNotificationModelImpl _$$PushNotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PushNotificationModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String? ?? "",
      pushDate: DateTime.parse(json['pushDate'] as String),
      flowId: json['flowId'] as String,
    );

Map<String, dynamic> _$$PushNotificationModelImplToJson(
        _$PushNotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
      'pushDate': instance.pushDate.toIso8601String(),
      'flowId': instance.flowId,
    };
