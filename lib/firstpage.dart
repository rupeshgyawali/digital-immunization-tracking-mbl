import 'package:digital_immunization_tracking/healthpersonal.dart';
import 'package:digital_immunization_tracking/child.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    final myLoginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.all(20),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HealthPersonal()));
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
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: 300,
        padding: EdgeInsets.all(20),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Child()));
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
      body: SingleChildScrollView(
          child: Center(
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width),
                        height: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.dstATop),
                              image: NetworkImage(
                                  'https://media.istockphoto.com/photos/doctor-giving-an-injection-vaccine-to-a-girl-little-girl-crying-with-picture-id1025414242?k=6&m=1025414242&s=612x612&w=0&h=NZVqNKu15qSleWuFERrzfvhK-JFvOdHef2bqJCrXKqY=')),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                          color: Colors.lightBlue[200],
                        ),
                        child: SizedBox(
                          child: Text(
                            'LOGIN AS',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 27,
                              color: Colors.white70,
                              height: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 7,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.yellow[100],
                              decorationStyle: TextDecorationStyle.double,
                              decorationThickness: 1.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      myLoginButton,
                      SizedBox(
                        height: 20,
                      ),
                      myLoginButton1,
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  )))),
    );
  }
}
