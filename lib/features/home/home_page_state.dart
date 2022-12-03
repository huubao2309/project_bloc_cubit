import 'package:project_bloc_cubit/base/bloc_state.dart';
import 'package:project_bloc_cubit/models/home_model.dart';

abstract class HomePageState extends BlocState {}

class HomePageLoading extends HomePageState {
  HomePageLoading();
}

class HomePageInitDataLoaded extends HomePageState {
  final HomeModel homeModel;

  HomePageInitDataLoaded({
    required this.homeModel,
  });
}

class HomePageFailed extends HomePageState {
  final String errorMsg;

  HomePageFailed({required this.errorMsg});
}
