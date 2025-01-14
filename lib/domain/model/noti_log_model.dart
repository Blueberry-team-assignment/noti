class NotiLogModel {
  final String id;
  final String userId;
  final String notiId;
  final bool isDone;
  final String? desc; // 성공했을 때 피드백, 실패했을 때 사유
  final DateTime startTime;
  final DateTime endTime;

  const NotiLogModel({
    required this.id,
    required  this.userId,
    required this.notiId,
    required this.isDone,
    this.desc,
    required this.startTime,
    required this.endTime,
  });
}
