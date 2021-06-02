import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../core/models/app_state.dart';
import '../../core/routes/route_paths.dart';
import '../../core/widgets/text_field.dart';
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
        authRepository: context.read<AuthRepository>(),
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
                    HealthPersonnelLoginForm(),
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

class HealthPersonnelLoginForm extends StatefulWidget {
  @override
  _HealthPersonnelLoginFormState createState() =>
      _HealthPersonnelLoginFormState();
}

class _HealthPersonnelLoginFormState extends State<HealthPersonnelLoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          context.watch<HealthPersonnelLoginProvider>().hasError
              ? Center(
                  child: Text(
                    context.watch<HealthPersonnelLoginProvider>().errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : Center(),
          DitTextFormField(
            label: 'Email',
            onSaved: context.read<HealthPersonnelLoginProvider>().setEmail,
            validator: MultiValidator([
              RequiredValidator(errorText: 'This field is required.'),
              EmailValidator(errorText: 'Email is not valid.')
            ]),
          ),
          DitTextFormField(
            label: 'Password',
            onSaved: context.read<HealthPersonnelLoginProvider>().setPassword,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          !context.watch<HealthPersonnelLoginProvider>().isLoading
              ? LoginButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus.unfocus();
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      await context
                          .read<HealthPersonnelLoginProvider>()
                          .login();
                      if (context
                              .read<HealthPersonnelLoginProvider>()
                              .loginSuccess ==
                          true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Login Successfull'),
                        ));
                        context.read<AppState>().setIsLoggedIn(true);
                        Navigator.popAndPushNamed(
                            context, RoutePath.child_selection);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Login Failed'),
                        ));
                      }
                    }
                  },
                )
              : Container(child: CircularProgressIndicator()),
        ],
      ),
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
