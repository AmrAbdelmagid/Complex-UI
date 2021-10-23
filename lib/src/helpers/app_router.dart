import 'package:complex_ui/src/presentation/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case Home.routeName:
          default:
            return const Home();
        }
      },
    );
  }
}
