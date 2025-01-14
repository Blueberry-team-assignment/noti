class NotiModel {
  final String id;
  final String category;
  final String title;
  final String? desc;
  final List<DateTime> startTimes; // 도달하면 호출되고, 반복주기 더해서 다시 리스트에 add.
  final Duration timeLimit;
  final bool isRepeating;
  final Duration? repeatInterval;

  NotiModel({
    required this.id,
    required this.category,
    required this.title,
    this.desc,
    required this.startTimes,
    required this.timeLimit,
    required this.isRepeating,
    this.repeatInterval,
  });
}
