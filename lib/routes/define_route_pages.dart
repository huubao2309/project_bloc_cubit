import 'package:project_bloc_cubit/features/detail/detail_page.dart';
import 'package:project_bloc_cubit/features/home/home_page.dart';
import 'package:project_bloc_cubit/features/splash/splash_page.dart';
import 'package:project_bloc_cubit/routes/define_routes.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  Navigator.defaultRouteName: (context) => const SplashPage(),
  routeNamedHomePage: (context) => HomePage(),
  routeNamedDetailPage: (context) => const DetailPage(),
};
