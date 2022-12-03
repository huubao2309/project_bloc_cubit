import 'package:project_bloc_cubit/routes/define_route_pages.dart';
import 'package:flutter/material.dart';
import 'package:project_bloc_cubit/utils/extension_navigation.dart';
import 'package:project_bloc_cubit/utils/local_notification.dart';
import 'package:project_bloc_cubit/utils/route_observer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalNotification.instance.configLocalNotificationFCM();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GetNavigation.instance.navigatorKey, // set property
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      navigatorObservers: [RouteNavigatorObserver.instance],
    );
  }
}
