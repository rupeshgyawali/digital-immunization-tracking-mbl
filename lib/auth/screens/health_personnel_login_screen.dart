import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_paths.dart';
import '../providers/health_personnel_login_provider.dart';
import '../repositories/auth_repository.dart';

TextStyle myStyle = TextStyle(fontSize: 25);

class HealthPersonalLoginScreen extends StatefulWidget {
  @override
  _HealthPersonalLoginScreenState createState() =>
      _HealthPersonalLoginScreenState();
}

class _HealthPersonalLoginScreenState extends State<HealthPersonalLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HealthPersonnelLoginProvider(
        authRepository: Provider.of<AuthRepository>(context, listen: false),
      ),
      child: Consumer<HealthPersonnelLoginProvider>(
        builder: (context, provider, child) => Scaffold(
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
                    EmailField(),
                    SizedBox(
                      height: 20,
                    ),
                    PasswordField(),
                    SizedBox(
                      height: 20,
                    ),
                    !Provider.of<HealthPersonnelLoginProvider>(context)
                            .isLoading
                        ? LoginButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus.unfocus();
                              await Provider.of<HealthPersonnelLoginProvider>(
                                      context,
                                      listen: false)
                                  .login();
                              if (Provider.of<HealthPersonnelLoginProvider>(
                                          context,
                                          listen: false)
                                      .loginSuccess ==
                                  true) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text('Login Successfull'),
                                ));
                                Navigator.pushNamed(
                                    context, RoutePath.child_selection);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text('Login Failed'),
                                ));
                              }
                            },
                          )
                        : Container(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        Provider.of<HealthPersonnelLoginProvider>(context, listen: false)
            .setEmail(val);
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
  }
}

class PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        Provider.of<HealthPersonnelLoginProvider>(context, listen: false)
            .setPassword(val);
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
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.lightBlueAccent,
      child: MaterialButton(
        minWidth: 250,
        padding: EdgeInsets.all(10),
        onPressed: this.onPressed,
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 20),
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
