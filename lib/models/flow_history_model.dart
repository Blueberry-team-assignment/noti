import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/flow_history_model.freezed.dart';
part 'generated/flow_history_model.g.dart';

@freezed
class FlowHistoryModel with _$FlowHistoryModel {
  const factory FlowHistoryModel({
    required String id,
    String? flowId,
    String? userId,
    required int flowTime, // 진행한 총 시간(초)
    required int round, // 몇 회차 진행했는지
    required String flowName,
    required DateTime date,
    @Default("") String notes,
  }) = _FlowHistoryModel;

  factory FlowHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$FlowHistoryModelFromJson(json);
}
