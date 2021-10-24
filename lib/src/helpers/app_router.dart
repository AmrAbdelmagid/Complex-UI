import 'package:complex_ui/src/constants/routes.dart';
import 'package:complex_ui/src/presentation/screens/01-home/home.dart';
import 'package:complex_ui/src/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case homeRoute:
          default:
            return const CustomDrawer();
        }
      },
    );
  }
}
