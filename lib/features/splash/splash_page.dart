import 'package:project_bloc_cubit/base/base_init.dart';
import 'package:project_bloc_cubit/features/home/notification/notification_home_cubit.dart';
import 'package:project_bloc_cubit/routes/define_routes.dart';
import 'package:flutter/material.dart';
import 'package:project_bloc_cubit/utils/extension_navigation.dart';
import 'package:project_bloc_cubit/utils/local_notification.dart';
import 'package:project_bloc_cubit/utils/utils_app.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    printLog('didChangeDependencies at Splash Screen');
    Future.delayed(const Duration(seconds: 2)).then((value) {
      GetNavigation.instance.offAndToNamed(
        context,
        routeNamedHomePage,
      );
    });

    // Push notification
    testPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  void testPushNotification() {
    LocalNotification.instance.showNotification();

    // Show Notification at Home
    final notificationCubit = getIt.get<NotificationHomeCubit>();
    notificationCubit.receiveNotification(hasMessage: true);
  }
}
