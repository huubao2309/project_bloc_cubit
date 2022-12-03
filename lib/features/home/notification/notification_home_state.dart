import 'package:project_bloc_cubit/base/bloc_state.dart';

abstract class NotificationHomeState extends BlocState {}

class NotificationUnreadHome extends NotificationHomeState {
  NotificationUnreadHome();
}

class NotificationReadHome extends NotificationHomeState {
  NotificationReadHome();
}
