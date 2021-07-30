import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../child/screens/local/header_section.dart';
import '../../core/models/app_state.dart';
import '../../core/routes/route_paths.dart';
import '../../core/widgets/button.dart';
import '../repositories/auth_repository.dart';

class HealthPersonnelHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderSection(home: true),
          Transform.translate(
            offset: const Offset(0.0, -36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'add',
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black54,
                      child: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RoutePath.child_registration);
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'New',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'search',
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black54,
                      child: Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutePath.child_search);
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Existing',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: DitButton(
              label: 'Logout',
              textStyle: TextStyle(color: Colors.white),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                if (context.read<AppState>().isLoggedIn) {
                  context.read<AppState>().setIsLoggedIn(false);
                  try {
                    await context
                        .read<AuthRepository>()
                        .logoutHealthPersonnel();
                  } catch (e) {
                    print('During Logout ->' + e.toString());
                  }
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
