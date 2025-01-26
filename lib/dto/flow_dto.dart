import 'package:freezed_annotation/freezed_annotation.dart';

part 'flow_dto.freezed.dart';
part 'flow_dto.g.dart';

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
