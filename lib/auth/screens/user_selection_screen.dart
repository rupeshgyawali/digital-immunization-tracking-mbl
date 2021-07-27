import 'package:flutter/material.dart';

import '../../core/routes/route_paths.dart';

class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myLoginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        onPressed: () {
          Navigator.pushNamed(context, RoutePath.child_selection);
        },
        child: Text(
          'Health Personal',
          style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    final myLoginButton1 = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        onPressed: () {
          Navigator.pushNamed(context, RoutePath.child_search);
        },
        child: Text(
          'Child',
          style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width),
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop),
                      image: NetworkImage(
                        'https://media.istockphoto.com/photos/doctor-giving-an-injection-vaccine-to-a-girl-little-girl-crying-with-picture-id1025414242?k=6&m=1025414242&s=612x612&w=0&h=NZVqNKu15qSleWuFERrzfvhK-JFvOdHef2bqJCrXKqY=',
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    color: Colors.lightBlueAccent,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                myLoginButton,
                SizedBox(
                  height: 30,
                ),
                myLoginButton1,
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
