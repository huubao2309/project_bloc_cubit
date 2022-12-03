import 'package:project_bloc_cubit/entities/home_item.entity.dart';

class HomeEntity {
  final String? name;
  final List<HomeItemEntity>? data;
  final bool? hasError;

  HomeEntity({
    this.name,
    this.data,
    this.hasError,
  });

  HomeEntity.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        hasError = json['hasError'] as bool?,
        data = json['data'] != null ? _parseListData(json['data']) : null;

  static List<HomeItemEntity> _parseListData(List<dynamic> objects) {
    if (objects.isEmpty) {
      return <HomeItemEntity>[];
    }

    final homeItemEntities = <HomeItemEntity>[];
    for (var i = 0; i < objects.length; i++) {
      homeItemEntities.add(HomeItemEntity.fromJson(objects[i]));
    }

    return homeItemEntities;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'hasError': hasError,
        // 'data': data?.toJson(),
      };
}
