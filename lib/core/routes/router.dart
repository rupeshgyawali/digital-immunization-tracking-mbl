import 'package:flutter/material.dart';

import '../../auth/screens/health_personnel_login_screen.dart';
import '../../auth/screens/user_selection_screen.dart';
import '../../vaccination_record/screens/child_registration_screen.dart';
import '../../vaccination_record/screens/child_search_screen.dart';
import '../../vaccination_record/screens/child_selection_screen.dart';
import '../models/app_state.dart';
import 'route_paths.dart';

class Router {
  Router._();

  static Route<dynamic> generateRoute(
      RouteSettings settings, AppState appState) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => UserSelectionScreen());
      case '${RoutePath.user_selection}':
        return MaterialPageRoute(builder: (_) => UserSelectionScreen());
      case '${RoutePath.health_personnel_login}':
        return MaterialPageRoute(builder: (_) => HealthPersonalLoginScreen());
      case '${RoutePath.child_selection}':
        if (!appState.isLoggedIn) {
          return MaterialPageRoute(builder: (_) => HealthPersonalLoginScreen());
        }
        return MaterialPageRoute(builder: (_) => ChildSelectionScreen());
      case '${RoutePath.child_search}':
        return MaterialPageRoute(builder: (_) => ChildSearchScreen());
      case '${RoutePath.child_registration}':
        return MaterialPageRoute(builder: (_) => ChildRegistrationScreen());
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
