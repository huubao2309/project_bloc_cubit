import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_bloc_cubit/base/base_init.dart';
import 'package:project_bloc_cubit/data/get_home_data.dart';
import 'package:project_bloc_cubit/features/home/home_page_state.dart';
import 'package:project_bloc_cubit/models/home_model.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageLoading());

  Future<void> changeItemList(String fileName) async {
    final get = getIt.get<GetHomeData>();
    final result = await get.getHomeData(fileName);
    if (result.hasError == null || result.hasError!) {
      emit(HomePageFailed(errorMsg: 'Cannot get list with error!!!'));
      return;
    }

    emit(HomePageInitDataLoaded(homeModel: HomeModel.mappingHomeValue(result)!));
    return;
  }
}
