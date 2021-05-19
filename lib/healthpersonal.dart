import 'package:digital_immunization_tracking/client.dart';
import 'package:flutter/material.dart';

TextStyle myStyle = TextStyle(fontSize: 25);

class HealthPersonal extends StatefulWidget {
  @override
  _HealthPersonalState createState() => _HealthPersonalState();
}

class _HealthPersonalState extends State<HealthPersonal> {
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      onChanged: (val) {
        setState(() {
          email = val;
        });
      },
      style: myStyle,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "Email",
          hintStyle: TextStyle(fontSize: 20.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
    );
    final passwordField = TextField(
      onChanged: (val) {
        setState(() {
          password = val;
        });
      },
      obscureText: true,
      style: myStyle,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "Password",
          hintStyle: TextStyle(fontSize: 20.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
    );
    final myLoginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.lightBlueAccent,
      child: MaterialButton(
        minWidth: 250,
        padding: EdgeInsets.all(10),
        onPressed: () {
          if (email == "root@gmail.com" && password == "root") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Client()));
          } else {
            print("Login Failed");
          }
        },
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 20),
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
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                emailField,
                SizedBox(
                  height: 20,
                ),
                passwordField,
                SizedBox(
                  height: 20,
                ),
                myLoginButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    var firststartpoint = Offset(size.width / 4, size.height);
    var firstendpoint = Offset(size.width / 4 - size.width / 8, size.height);
    path.quadraticBezierTo(firststartpoint.dx, firststartpoint.dy,
        firstendpoint.dx, firstendpoint.dy);
    var secondstartpoint = Offset(size.width / 2, size.height);
    var secondendpoint = Offset(size.width, size.height - 110);
    path.quadraticBezierTo(secondstartpoint.dx, secondstartpoint.dy,
        secondendpoint.dx, secondendpoint.dy);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
