import 'package:project_bloc_cubit/entities/home_item.entity.dart';

class HomeItemModel extends HomeItemEntity {
  HomeItemModel({int? count, String? time})
      : super(
          count: count,
          time: time,
        );

  @override
  String toString() {
    return 'count: $count, time: $time';
  }

  static HomeItemModel? mappingHomeValue(HomeItemEntity? entity) {
    if (entity == null) {
      return null;
    }

    return HomeItemModel(count: entity.count, time: entity.time);
  }
}