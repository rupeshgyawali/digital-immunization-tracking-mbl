import 'package:flutter/material.dart';

import '../../auth/screens/user_selection_screen.dart';
import 'route_paths.dart';

class Router {
  Router._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => UserSelectionScreen());
      case '${RoutePath.user_selection}':
        return MaterialPageRoute(builder: (_) => UserSelectionScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
