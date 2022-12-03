import 'package:flutter/material.dart';
import 'package:project_bloc_cubit/utils/route_observer.dart';

class GetNavigation {
  GetNavigation._();

  static final GetNavigation _instance = GetNavigation._();

  static GetNavigation get instance => _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void toNamed(
    BuildContext context,
    String page, {
    dynamic arguments,
    bool preventDuplicates = true,
  }) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final previousRoute = RouteNavigatorObserver.instance.previousRoutePage;
    if (preventDuplicates && currentRoute != null && previousRoute != null && previousRoute == currentRoute) {
      return;
    }

    RouteNavigatorObserver.instance.currentRoutePage = page;
    Navigator.pushNamed(
      context,
      page,
      arguments: arguments,
    );
  }

  void offAndToNamed(
    BuildContext context,
    String page, {
    dynamic arguments,
    bool preventDuplicates = true,
  }) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final previousRoute = RouteNavigatorObserver.instance.previousRoutePage;
    if (preventDuplicates && currentRoute != null && previousRoute != null && previousRoute == currentRoute) {
      return;
    }

    RouteNavigatorObserver.instance.currentRoutePage = page;
    Navigator.pushReplacementNamed(
      context,
      page,
      arguments: arguments,
    );
  }
}
