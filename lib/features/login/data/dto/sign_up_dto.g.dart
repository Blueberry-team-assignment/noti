// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpDtoImpl _$$SignUpDtoImplFromJson(Map<String, dynamic> json) =>
    _$SignUpDtoImpl(
      email: json['email'] as String,
      pw: json['pw'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$SignUpDtoImplToJson(_$SignUpDtoImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'pw': instance.pw,
      'name': instance.name,
    };
