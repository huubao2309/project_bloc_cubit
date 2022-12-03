import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_bloc_cubit/features/home/footer/footer_home_state.dart';

class FooterHomeCubit extends Cubit<FooterHomeState> {
  FooterHomeCubit() : super(FooterOnlineHome());

  Future<void> changeStatusFooter({required bool hasOnline}) async {
    if (hasOnline) {
      emit(FooterOnlineHome());
      return;
    }

    emit(FooterOfflineHome());
    return;
  }
}