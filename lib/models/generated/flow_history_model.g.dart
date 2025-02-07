// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../flow_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlowHistoryModelImpl _$$FlowHistoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FlowHistoryModelImpl(
      id: json['id'] as String,
      flowId: json['flowId'] as String,
      userId: json['userId'] as String,
      flowTime: (json['flowTime'] as num).toInt(),
      round: (json['round'] as num).toInt(),
      flowName: json['flowName'] as String,
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String? ?? "",
    );

Map<String, dynamic> _$$FlowHistoryModelImplToJson(
        _$FlowHistoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'flowId': instance.flowId,
      'userId': instance.userId,
      'flowTime': instance.flowTime,
      'round': instance.round,
      'flowName': instance.flowName,
      'date': instance.date.toIso8601String(),
      'notes': instance.notes,
    };
