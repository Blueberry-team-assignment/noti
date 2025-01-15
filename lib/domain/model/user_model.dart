class UserModel {
  final String uid;
  final String email;
  final String name;
  final List<String>? recentFlowHistoryIds;

  UserModel({
    required this.email,
    required this.uid,
    required this.name,
    this.recentFlowHistoryIds,
  });
}
