// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlowHistoryModelImpl _$$FlowHistoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FlowHistoryModelImpl(
      id: json['id'] as String,
      flowId: json['flowId'] as String,
      userId: json['userId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      flowCount: (json['flowCount'] as num).toInt(),
      isSuccess: json['isSuccess'] as bool,
      notes: json['notes'] as String? ?? "",
    );

Map<String, dynamic> _$$FlowHistoryModelImplToJson(
        _$FlowHistoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'flowId': instance.flowId,
      'userId': instance.userId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'flowCount': instance.flowCount,
      'isSuccess': instance.isSuccess,
      'notes': instance.notes,
    };
