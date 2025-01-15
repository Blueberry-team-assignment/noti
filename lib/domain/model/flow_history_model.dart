class FlowHistoryModel {
  final String id;
  final String flowId;
  final String userId;
  final Duration duration;
  final DateTime startTime;
  final DateTime endTime;
  final int flowCount;
  final bool isSuccess;
  final String notes;

  FlowHistoryModel({
    required this.id,
    required this.flowId,
    required this.userId,
    required this.duration,
    required this.startTime,
    required this.endTime,
    required this.flowCount,
    required this.isSuccess,
    this.notes = "",
  });
}
