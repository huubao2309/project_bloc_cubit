import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project_bloc_cubit/routes/define_routes.dart';
import 'package:project_bloc_cubit/utils/extension_navigation.dart';

// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:project_bloc_cubit/utils/route_observer.dart';
import 'package:project_bloc_cubit/utils/utils_app.dart';

class LocalNotification {
  LocalNotification._();

  static final LocalNotification _instance = LocalNotification._();

  static LocalNotification get instance => _instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> showNotification() async {
    tz.initializeTimeZones();
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'com.project.bloc_cubit.project_bloc_cubit',
      'Bloc Cubit',
      channelDescription: 'Test',
      playSound: true,
      visibility: NotificationVisibility.public,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    const platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      Random().nextInt(pow(2, 31).toInt() - 1),
      'Title: ${DateTime.now()}',
      'Body: ${DateTime.now()}',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: '2', // hard code
    );
  }

  void configLocalNotificationFCM() {
    try {
      const initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
      const initializationSettingsDarwin = DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      );
      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );
      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (value) async {
          printLog('Value Notification: ${value.payload}');

          return await _handleWhenClickNotifyFCMOnForeGround(payload: value.payload);
        },
        // onDidReceiveBackgroundNotificationResponse: myBackgroundMessageHandler,
      );
    } catch (ex, stackTrace) {
      printLog('Error configLocalNotificationFCM: $ex, stackTrace: $stackTrace');
    }
  }

  Future<void> _handleWhenClickNotifyFCMOnForeGround({required String? payload}) async {
    final currentRoute = RouteNavigatorObserver.instance.currentRoutePage;
    if (currentRoute == routeNamedHomePage) {
      printLog('Value Notification at Home: $payload');
      final context = GetNavigation.instance.navigatorKey.currentContext;
      if (context != null) {
        navigateToDetailPage(context, payload ?? '1');
      }
      return;
    }

    printLog('Value Notification at other page: $payload');
  }

  void navigateToDetailPage(BuildContext context, String item) {
    GetNavigation.instance.toNamed(
      context,
      routeNamedDetailPage,
      arguments: item,
    );
  }
}
