class FlowModel {
  final String id;
  final String name;
  final String category;
  final Duration duration;  // 1플로우의 총 시간
  final String ratio; // 몰입-휴식 비율
  final String desc;

  FlowModel({
    required this.id,
    required this.name,
    required this.category,
    required this.duration,
    required this.ratio,
    this.desc = "",
  });
}
