import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_notification_model.freezed.dart';
part 'push_notification_model.g.dart';

@freezed
class PushNotificationModel with _$PushNotificationModel {
  const factory PushNotificationModel({
    required String id,
    required String title,
    @Default("") String desc,
    required DateTime pushDate, // 알림 발송 시각
    required String flowId,
  }) = _PushNotificationModel;

  factory PushNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationModelFromJson(json);
}
