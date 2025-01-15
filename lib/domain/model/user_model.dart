class UserModel {
  final String uid;
  final String email;
  final String name;
  final List<String>? recentFlowHistoryIds; // 최근 n개의 히스토리만 빠르게 보여주기 위해
  final bool isAuthUser;  // 회원인지 비회원인지

  UserModel({
    required this.email,
    required this.uid,
    required this.name,
    this.recentFlowHistoryIds,
    required this.isAuthUser,
  });
}
