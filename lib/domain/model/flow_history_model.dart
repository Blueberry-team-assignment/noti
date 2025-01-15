class FlowHistoryModel {
  final String id;
  final String flowId;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final int flowCount;    // 몇 회차인지
  final bool isSuccess;
  final String notes;

  FlowHistoryModel({
    required this.id,
    required this.flowId,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.flowCount,
    required this.isSuccess,
    this.notes = "",
  });
}
