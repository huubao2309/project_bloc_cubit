import 'package:get_it/get_it.dart';
import 'package:project_bloc_cubit/data/get_home_data.dart';
import 'package:project_bloc_cubit/data/get_home_data_impl.dart';
import 'package:project_bloc_cubit/features/home/footer/footer_home_cubit.dart';
import 'package:project_bloc_cubit/features/home/home_page_cubit.dart';
import 'package:project_bloc_cubit/features/home/notification/notification_home_cubit.dart';

GetIt getIt = GetIt.instance;

void initBaseApp() {
  getIt.registerLazySingleton<GetHomeData>(() => GetHomeDataImplement());
  getIt.registerLazySingleton<HomePageCubit>(() => HomePageCubit());
  getIt.registerLazySingleton<NotificationHomeCubit>(() => NotificationHomeCubit());
  getIt.registerLazySingleton<FooterHomeCubit>(() => FooterHomeCubit());
}
