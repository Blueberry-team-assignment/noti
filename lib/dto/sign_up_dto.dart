import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/sign_up_dto.freezed.dart';
part 'generated/sign_up_dto.g.dart';

/*  사용자의 회원가입 요청에 필요한 정보를 담기 위한 DTO 객체입니다.
 */
@freezed
class SignUpDto with _$SignUpDto {
  factory SignUpDto({
    String? uid,
    String? email,
    String? password,
    String? name,
    required bool isAuthUser,
  }) = _SignUpDto;

  factory SignUpDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpDtoFromJson(json);
}
