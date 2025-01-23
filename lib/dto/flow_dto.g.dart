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
      ratio: json['ratio'] as String?,
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$$FlowDtoImplToJson(_$FlowDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'duration': instance.duration?.inMicroseconds,
      'ratio': instance.ratio,
      'desc': instance.desc,
    };
