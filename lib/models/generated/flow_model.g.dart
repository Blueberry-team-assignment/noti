// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../flow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlowModelImpl _$$FlowModelImplFromJson(Map<String, dynamic> json) =>
    _$FlowModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      ratio: json['ratio'] as String,
      desc: json['desc'] as String? ?? "",
    );

Map<String, dynamic> _$$FlowModelImplToJson(_$FlowModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'duration': instance.duration.inMicroseconds,
      'ratio': instance.ratio,
      'desc': instance.desc,
    };
