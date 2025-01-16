import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_dto.freezed.dart';
part 'sign_up_dto.g.dart';

@freezed
class SignUpDto with _$SignUpDto {
  factory SignUpDto({
    String? email,
    String? pw,
    String? name,
    required bool isAuthUser,
  }) = _SignUpDto;

  factory SignUpDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpDtoFromJson(json);
}
