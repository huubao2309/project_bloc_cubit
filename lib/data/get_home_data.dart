import 'package:project_bloc_cubit/entities/home_entity.dart';

abstract class GetHomeData {
  Future<HomeEntity> getHomeData(String fileName);
}