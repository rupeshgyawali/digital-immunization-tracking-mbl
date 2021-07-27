import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../core/models/app_state.dart';
import '../../core/routes/route_paths.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/header_clipper.dart';
import '../../core/widgets/text_field.dart';
import '../providers/health_personnel_login_provider.dart';
import '../repositories/auth_repository.dart';

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
          body: Column(
            children: [
              Expanded(
                child: ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'Health\nPersonnel',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: HealthPersonnelLoginForm(),
                ),
              ),
            ],
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
              ? DitButton(
                  label: 'Login',
                  minWidth: 250,
                  textStyle: TextStyle(color: Colors.white, fontSize: 20),
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
