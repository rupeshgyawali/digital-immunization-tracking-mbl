import 'package:flutter/material.dart';

import '../../auth/screens/app_home_screen.dart';
import '../../auth/screens/child_login_screen.dart';
import '../../auth/screens/health_personnel_home_screen.dart';
import '../../auth/screens/health_personnel_login_screen.dart';
import '../../child/models/child_model.dart';
import '../../child/screens/child_home_screen.dart';
import '../../child/screens/child_registration_screen.dart';
import '../../child/screens/child_search_screen.dart';
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
        return _materialPageRoute(AppHomeScreen());
      case '${RoutePath.app_home}':
        return _materialPageRoute(AppHomeScreen());
      case '${RoutePath.health_personnel_login}':
        return _slideTransitionRoute(HealthPersonalLoginScreen());
      case '${RoutePath.health_personnel_home}':
        if (!appState.isLoggedIn) {
          return _slideTransitionRoute(HealthPersonalLoginScreen());
        }
        return _materialPageRoute(HealthPersonnelHomeScreen());
      case '${RoutePath.child_search}':
        return _materialPageRoute(ChildSearchScreen());
      case '${RoutePath.child_registration}':
        return _materialPageRoute(ChildRegistrationScreen());
      case '${RoutePath.child_login}':
        return _slideTransitionRoute(ChildLoginScreen());
      case '${RoutePath.child_home}':
        if (appState.children == null || appState.children.isEmpty) {
          return _slideTransitionRoute(ChildLoginScreen());
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

  static Route<dynamic> _slideTransitionRoute(Widget screen,
      {RouteSettings routeSettings}) {
    return PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (context, animation, secAnimation) => screen,
      transitionsBuilder: (context, animation, secAnimation, child) {
        animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
        return SlideTransition(
          position: Tween(
            begin: Offset(1.0, 0.0),
            end: Offset(0.0, 0.0),
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
