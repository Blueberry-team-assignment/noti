class PushNotificationModel {
  final String id;
  final String title;
  final String desc;
  final DateTime pushDate;  // 알림 발송 시각
  final String flowId;

  PushNotificationModel({
    required this.id,
    required this.title,
    this.desc = "",
    required this.pushDate,
    required this.flowId,
  });
}
