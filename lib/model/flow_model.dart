import 'package:freezed_annotation/freezed_annotation.dart';

part 'flow_model.freezed.dart';
part 'flow_model.g.dart';

@freezed
class FlowModel with _$FlowModel {
  const factory FlowModel({
    required String id,
    required String name,
    required String category,
    required Duration duration, // 1 플로우의 총 시간
    required String ratio, // 몰입-휴식 비율
    @Default("") String desc,
  }) = _FlowModel;

  factory FlowModel.fromJson(Map<String, dynamic> json) =>
      _$FlowModelFromJson(json);
}
