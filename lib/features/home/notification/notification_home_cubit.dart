import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_bloc_cubit/features/home/notification/notification_home_state.dart';

class NotificationHomeCubit extends Cubit<NotificationHomeState> {
  NotificationHomeCubit() : super(NotificationReadHome());

  Future<void> receiveNotification({required bool hasMessage}) async {
    if (hasMessage) {
      emit(NotificationUnreadHome());
      return;
    }

    emit(NotificationReadHome());
    return;
  }
}
