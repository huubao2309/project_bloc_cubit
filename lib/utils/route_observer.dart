import 'package:flutter/material.dart';
import 'package:project_bloc_cubit/utils/utils_app.dart';

class RouteNavigatorObserver extends RouteObserver<PageRoute> {
  RouteNavigatorObserver._();

  static final RouteNavigatorObserver _instance = RouteNavigatorObserver._();

  static RouteNavigatorObserver get instance => _instance;

  String? currentRoutePage;
  String? previousRoutePage;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    printLog('Call did push navigator with route = ${route.settings.name}, previousRoute = ${previousRoute?.settings.name}');
    previousRoutePage = previousRoute?.settings.name;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    printLog('Call did pop navigator with route = ${route.settings.name}, previousRoute = ${previousRoute?.settings.name}');
    previousRoutePage = route.settings.name;
  }


}
