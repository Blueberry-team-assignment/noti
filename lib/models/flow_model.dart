import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/flow_model.freezed.dart';
part 'generated/flow_model.g.dart';

@freezed
class FlowModel with _$FlowModel {
  const factory FlowModel({
    required String id,
    required String name,
    String? category,
    Duration? duration, // 1 플로우의 총 시간
    required Duration focusTime,
    required Duration restTime,
    @Default("") String desc,
  }) = _FlowModel;

  factory FlowModel.fromJson(Map<String, dynamic> json) =>
      _$FlowModelFromJson(json);
}
