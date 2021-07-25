import 'package:digital_immunization_tracking/client.dart';
import 'package:flutter/material.dart';

TextStyle myStyle = TextStyle(
  fontSize: 25,
);

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
      decoration: InputDecoration(
          hintText: "Email",
          labelText: "Email",
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.blueGrey[100]),
          labelStyle: TextStyle(
            fontSize: 28,
          ),
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Colors.black38,
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final passwordField = TextField(
      onChanged: (val) {
        setState(() {
          password = val;
        });
      },
      obscureText: true,
      style: myStyle,
      decoration: InputDecoration(
          hintText: "Password",
          labelText: "Password",
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.blueGrey[100]),
          labelStyle: TextStyle(fontSize: 28),
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black38,
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final myLoginButton = Material(
      elevation: 5.0,
      color: Colors.lightBlue[200],
      child: MaterialButton(
        minWidth: 200,
        padding: EdgeInsets.all(13),
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
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
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[200],
                    ),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                SizedBox(
                  height: 3,
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
    var firststartpoint = Offset(size.width / 10, size.height);
    var firstendpoint = Offset(size.width / 8 + size.width / 10, size.height);
    path.quadraticBezierTo(firststartpoint.dx, firststartpoint.dy,
        firstendpoint.dx, firstendpoint.dy);
    var secondstartpoint = Offset(size.width / 2, size.height);
    var secondendpoint = Offset(size.width, size.height - 110);
    path.quadraticBezierTo(secondstartpoint.dx, secondstartpoint.dy,
        secondendpoint.dx, secondendpoint.dy);
    var thirdstartpoint = Offset(size.width / 2, size.height);
    var thirdendpoint = Offset(size.width, size.height - 110);
    path.quadraticBezierTo(thirdstartpoint.dx, thirdstartpoint.dy,
        thirdendpoint.dx, thirdendpoint.dy);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
