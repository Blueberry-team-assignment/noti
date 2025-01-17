import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/flow_history_model.freezed.dart';
part 'generated/flow_history_model.g.dart';

@freezed
class FlowHistoryModel with _$FlowHistoryModel {
  const factory FlowHistoryModel({
    required String id,
    required String flowId,
    required String userId,
    required DateTime startTime,
    required DateTime endTime,
    required int flowCount, // 몇 회차인지
    required bool isSuccess,
    @Default("") String notes,
  }) = _FlowHistoryModel;

  factory FlowHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$FlowHistoryModelFromJson(json);
}
