import 'package:flutter/material.dart';
import 'core/routes/router.dart' as appRouter;

void main() {
  runApp(DigitalImmunizationTrackingApp());
}

class DigitalImmunizationTrackingApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Immunization Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) =>
          appRouter.Router.generateRoute(settings),
    );
  }
}
