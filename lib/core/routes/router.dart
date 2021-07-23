import 'package:flutter/material.dart';

import '../../auth/screens/health_personnel_login_screen.dart';
import '../../auth/screens/user_selection_screen.dart';
import '../../vaccination_record/models/child_model.dart';
import '../../vaccination_record/screens/child_details_screen.dart';
import '../../vaccination_record/screens/child_registration_screen.dart';
import '../../vaccination_record/screens/child_search_screen.dart';
import '../../vaccination_record/screens/child_selection_screen.dart';
import '../models/app_state.dart';
import 'route_paths.dart';

class Router {
  Router._();

  static RouteSettings routeSettings;

  static Route<dynamic> generateRoute(
      RouteSettings settings, AppState appState) {
    routeSettings = settings;
    switch (settings.name) {
      case '/':
        return _materialPageRoute(UserSelectionScreen());
      case '${RoutePath.user_selection}':
        return _materialPageRoute(UserSelectionScreen());
      case '${RoutePath.health_personnel_login}':
        return _materialPageRoute(HealthPersonalLoginScreen());
      case '${RoutePath.child_selection}':
        if (!appState.isLoggedIn) {
          return _materialPageRoute(HealthPersonalLoginScreen());
        }
        return _materialPageRoute(ChildSelectionScreen());
      case '${RoutePath.child_search}':
        return _materialPageRoute(ChildSearchScreen());
      case '${RoutePath.child_registration}':
        return _materialPageRoute(ChildRegistrationScreen());
      case '${RoutePath.child_details}':
        final args = settings.arguments;

        if (args is Child) {
          return _materialPageRoute(ChildDetailsScreen(child: args));
        }

        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => Scaffold(
        body: Center(
          child: Text('Route Error for ${routeSettings.name}'),
        ),
      ),
    );
  }

  static Route<dynamic> _materialPageRoute(Widget screen) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => screen,
    );
  }
}
