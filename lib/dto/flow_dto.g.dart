// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlowDtoImpl _$$FlowDtoImplFromJson(Map<String, dynamic> json) =>
    _$FlowDtoImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      focusTime: json['focusTime'] == null
          ? null
          : Duration(microseconds: (json['focusTime'] as num).toInt()),
      restTime: json['restTime'] == null
          ? null
          : Duration(microseconds: (json['restTime'] as num).toInt()),
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$$FlowDtoImplToJson(_$FlowDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'duration': instance.duration?.inMicroseconds,
      'focusTime': instance.focusTime?.inMicroseconds,
      'restTime': instance.restTime?.inMicroseconds,
      'desc': instance.desc,
    };
