import 'package:flutter/material.dart';

import '../../core/routes/route_paths.dart';
import '../../core/widgets/button.dart';

class AppHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  image: AssetImage('assets/cover.jpg'),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(
                  'LOGIN AS',
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 7,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  DitButtonExpanded(
                    label: 'Health Personal',
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RoutePath.health_personnel_home);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DitButtonExpanded(
                    label: 'Child',
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePath.child_home);
                    },
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
