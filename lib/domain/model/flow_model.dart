class FlowModel {
  final String id;
  final String name;
  final String category;
  final Duration duration;
  final String ratio;
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
