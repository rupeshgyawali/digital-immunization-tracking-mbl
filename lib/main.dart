import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routes/router.dart' as appRouter;
import 'injection.dart';

void main() {
  runApp(DigitalImmunizationTrackingApp());
}

class DigitalImmunizationTrackingApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus.unfocus();
      },
      child: MultiProvider(
        providers: [
          ...providers,
        ],
        child: MaterialApp(
          title: 'Digital Immunization Tracking',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) =>
              appRouter.Router.generateRoute(settings),
        ),
      ),
    );
  }
}
