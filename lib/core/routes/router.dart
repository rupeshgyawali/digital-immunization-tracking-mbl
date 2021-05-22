import 'package:flutter/material.dart';

import '../../auth/screens/health_personnel_login_screen.dart';
import '../../auth/screens/user_selection_screen.dart';
import '../../vaccination_record/screens/child_search_screen.dart';
import '../../vaccination_record/screens/child_selection_screen.dart';
import 'route_paths.dart';

class Router {
  Router._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => UserSelectionScreen());
      case '${RoutePath.user_selection}':
        return MaterialPageRoute(builder: (_) => UserSelectionScreen());
      case '${RoutePath.health_personnel_login}':
        return MaterialPageRoute(builder: (_) => HealthPersonalLoginScreen());
      case '${RoutePath.child_selection}':
        return MaterialPageRoute(builder: (_) => ChildSelectionScreen());
      case '${RoutePath.child_search}':
        return MaterialPageRoute(builder: (_) => ChildSearchScreen());
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
