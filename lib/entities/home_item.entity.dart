class HomeItemEntity {
  final int? count;
  final String? time;

  HomeItemEntity({
    this.count,
    this.time,
  });

  HomeItemEntity.fromJson(Map<String, dynamic> json)
      : count = json['count'] as int?,
        time = json['time'] as String?;

  Map<String, dynamic> toJson() => {
    'count': count,
    'time': time,
  };
}