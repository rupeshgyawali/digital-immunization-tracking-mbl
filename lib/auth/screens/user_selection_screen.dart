import 'package:flutter/material.dart';

import '../../core/routes/route_paths.dart';
import '../../core/widgets/button.dart';

class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  image: NetworkImage(
                    'https://media.istockphoto.com/photos/doctor-giving-an-injection-vaccine-to-a-girl-little-girl-crying-with-picture-id1025414242?k=6&m=1025414242&s=612x612&w=0&h=NZVqNKu15qSleWuFERrzfvhK-JFvOdHef2bqJCrXKqY=',
                  ),
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
                  DitButton.expanded(
                    label: 'Health Personal',
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePath.child_selection);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DitButton.expanded(
                    label: 'Child',
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePath.child_search);
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
