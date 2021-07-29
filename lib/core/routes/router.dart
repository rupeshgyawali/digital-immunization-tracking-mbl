import 'package:flutter/material.dart';

import '../../auth/screens/child_login_screen.dart';
import '../../auth/screens/health_personnel_login_screen.dart';
import '../../auth/screens/user_selection_screen.dart';
import '../../child/models/child_model.dart';
import '../../child/screens/child_home_screen.dart';
import '../../child/screens/child_registration_screen.dart';
import '../../child/screens/child_search_screen.dart';
import '../../child/screens/new_or_existing_child_screen.dart';
import '../../vaccination_record/screens/child_vaccine_record_screen.dart';
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
        return _materialPageRoute(NewOrExistingChildScreen());
      case '${RoutePath.child_search}':
        return _materialPageRoute(ChildSearchScreen());
      case '${RoutePath.child_registration}':
        return _materialPageRoute(ChildRegistrationScreen());
      case '${RoutePath.child_login}':
        return _materialPageRoute(ChildLoginScreen());
      case '${RoutePath.child_home}':
        if (appState.children == null || appState.children.isEmpty) {
          return _materialPageRoute(ChildLoginScreen());
        }
        return _materialPageRoute(ChildHomeScreen(children: appState.children));
      case '${RoutePath.child_details}':
        final args = settings.arguments;

        if (args is Child) {
          return _materialPageRoute(ChildVaccineRecordScreen(child: args));
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
