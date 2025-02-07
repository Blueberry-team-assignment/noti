// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../flow_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlowHistoryDtoImpl _$$FlowHistoryDtoImplFromJson(Map<String, dynamic> json) =>
    _$FlowHistoryDtoImpl(
      id: json['id'] as String?,
      flowId: json['flowId'] as String?,
      userId: json['userId'] as String?,
      flowTime: (json['flowTime'] as num?)?.toInt() ?? 0,
      round: (json['round'] as num?)?.toInt() ?? 1,
      flowName: json['flowName'] as String? ?? "",
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String? ?? "",
    );

Map<String, dynamic> _$$FlowHistoryDtoImplToJson(
        _$FlowHistoryDtoImpl instance) =>
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
