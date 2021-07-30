import 'package:flutter/material.dart';

import '../../child/screens/local/header_section.dart';
import '../../core/routes/route_paths.dart';

class HealthPersonnelHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderSection(),
          Transform.translate(
            offset: const Offset(0.0, -36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    FloatingActionButton(
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
        ],
      ),
    );
  }
}
