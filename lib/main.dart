import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/models/app_state.dart';
import 'core/routes/router.dart' as appRouter;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppState appState = AppState();
  await appState.loadStateFromCache();

  runApp(DigitalImmunizationTrackingApp(appState: appState));
}

class DigitalImmunizationTrackingApp extends StatelessWidget {
  // This widget is the root of the application.

  final AppState appState;

  const DigitalImmunizationTrackingApp({Key key, this.appState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus.unfocus();
      },
      child: MultiProvider(
        providers: [
          Provider.value(value: this.appState),
          ...providers,
        ],
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Digital Immunization Tracking',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) =>
              appRouter.Router.generateRoute(
                  settings, Provider.of<AppState>(context, listen: false)),
        ),
      ),
    );
  }
}
