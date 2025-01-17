// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      recentFlowHistoryIds: (json['recentFlowHistoryIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isAuthUser: json['isAuthUser'] as bool,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'recentFlowHistoryIds': instance.recentFlowHistoryIds,
      'isAuthUser': instance.isAuthUser,
    };
