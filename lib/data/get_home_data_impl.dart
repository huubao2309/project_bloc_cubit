import 'package:project_bloc_cubit/data/get_home_data.dart';
import 'package:project_bloc_cubit/entities/home_entity.dart';
import 'package:project_bloc_cubit/utils/utils_app.dart';

class GetHomeDataImplement extends GetHomeData {
  @override
  Future<HomeEntity> getHomeData(String fileName) async {
    final value = await getJson(fileName);
    final result = HomeEntity.fromJson(value);
    return result;
  }
}
