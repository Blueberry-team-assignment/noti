import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/flow_history_dto.freezed.dart';
part 'generated/flow_history_dto.g.dart';

/*  사용자가 완료한 플로우 기록 정보를 담기 위한 DTO 객체입니다.
 */
@freezed
class FlowHistoryDto with _$FlowHistoryDto {
  const factory FlowHistoryDto({
    String? id,
    String? flowId,
    String? userId,
    @Default(0) int flowTime, // 총 진행한 시간(초)
    @Default(1) int round, // 몇 회차 진행했는지
    @Default("") String flowName,
    required DateTime date,
    @Default("") String notes,
  }) = _FlowHistoryDto;

  factory FlowHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$FlowHistoryDtoFromJson(json);
}
