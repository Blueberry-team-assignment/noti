import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/flow_dto.freezed.dart';
part 'generated/flow_dto.g.dart';

/*  사용자가 등록한 플로우의 정보를 담기 위한 DTO 객체입니다.
    UI에서 바깥 레이어로 데이터를 보내거나 db에 create/update 요청을 보낼 때 사용됩니다.
    freezed를 사용해 불변성을 확보, 기본 메서드 생성, json형식과 상호 변환을 용이하게 합니다.
 */
@freezed
class FlowDto with _$FlowDto {
  const factory FlowDto({
    String? id,
    String? name,
    String? category,
    Duration? duration,
    Duration? focusTime,
    Duration? restTime,
    String? desc,
  }) = _FlowDto;

  factory FlowDto.fromJson(Map<String, dynamic> json) =>
      _$FlowDtoFromJson(json);
}
