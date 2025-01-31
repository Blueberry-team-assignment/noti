// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../flow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlowModelImpl _$$FlowModelImplFromJson(Map<String, dynamic> json) =>
    _$FlowModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String?,
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      focusTime: Duration(microseconds: (json['focusTime'] as num).toInt()),
      restTime: Duration(microseconds: (json['restTime'] as num).toInt()),
      desc: json['desc'] as String? ?? "",
    );

Map<String, dynamic> _$$FlowModelImplToJson(_$FlowModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'duration': instance.duration?.inMicroseconds,
      'focusTime': instance.focusTime.inMicroseconds,
      'restTime': instance.restTime.inMicroseconds,
      'desc': instance.desc,
    };
