import 'dart:convert';

import 'package:project_bloc_cubit/entities/home_entity.dart';
import 'package:project_bloc_cubit/entities/home_item.entity.dart';
import 'package:project_bloc_cubit/models/home_item_model.dart';

class HomeModel extends HomeEntity {
  HomeModel({String? name, bool? hasError, List<HomeItemModel>? data})
      : super(
    name: name,
    hasError: hasError,
  ) {
    this.data = mappingHomeListItemValue(data);
  }

  List<HomeItemModel>? data;

  @override
  String toString() {
    return 'name: $name, hasError: $hasError, data: ${jsonEncode(data)}';
  }

  static HomeModel? mappingHomeValue(HomeEntity? entity) {
    if (entity == null) {
      return null;
    }

    if (entity.hasError == null || entity.hasError!) {
      return null;
    }

    return HomeModel(name: entity.name, hasError: entity.hasError, data: mappingHomeListItemValue(entity.data));
  }

  static List<HomeItemModel> mappingHomeListItemValue(List<HomeItemEntity>? items) {
    if (items == null || items.isEmpty) {
      return <HomeItemModel>[];
    }

    final result = <HomeItemModel>[];
    for (var i = 0; i < items.length; i++) {
      result.add(HomeItemModel.mappingHomeValue(items.elementAt(i))!);
    }
    return result;
  }
}