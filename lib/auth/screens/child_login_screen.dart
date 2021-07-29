import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../child/models/child_model.dart';
import '../../core/models/app_state.dart';
import '../../core/routes/route_paths.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/header_clipper.dart';
import '../../core/widgets/text_field.dart';
import '../providers/child_login_provider.dart';
import '../repositories/auth_repository.dart';

TextStyle myStyle = TextStyle(fontSize: 20);

class ChildLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChildLoginProvider(
        authRepository: context.read<AuthRepository>(),
      ),
      child: Consumer<ChildLoginProvider>(
        builder: (context, provider, child) => Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.dstATop),
                        image: NetworkImage(
                          'https://media.istockphoto.com/photos/doctor-giving-an-injection-vaccine-to-a-girl-little-girl-crying-with-picture-id1025414242?k=6&m=1025414242&s=612x612&w=0&h=NZVqNKu15qSleWuFERrzfvhK-JFvOdHef2bqJCrXKqY=',
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Child',
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
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ChildLoginForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildLoginForm extends StatefulWidget {
  @override
  _ChildLoginFormState createState() => _ChildLoginFormState();
}

class _ChildLoginFormState extends State<ChildLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpFieldController = TextEditingController();

  @override
  void dispose() {
    _otpFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          context.watch<ChildLoginProvider>().hasError
              ? Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      context.watch<ChildLoginProvider>().errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                )
              : Container(),
          DitTextFormField(
            label: 'Phone Number',
            icon: Icon(Icons.phone_android_outlined),
            onSaved: context.read<ChildLoginProvider>().setPhoneNo,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          context.watch<ChildLoginProvider>().otpSent
              ? DitTextFormField(
                  label: 'OTP',
                  controller: _otpFieldController,
                  icon: Icon(Icons.security_outlined),
                  onSaved: context.read<ChildLoginProvider>().setOtp,
                  validator:
                      RequiredValidator(errorText: 'This field is required'),
                )
              : Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text('We will send OTP to this phone number.'),
                ),
          !context.watch<ChildLoginProvider>().isLoading
              ? !context.watch<ChildLoginProvider>().otpSent
                  ? DitButton(
                      label: 'Send',
                      minWidth: 250,
                      textStyle: TextStyle(color: Colors.white, fontSize: 20),
                      onPressed: () async {
                        await onPressed(context);
                      },
                    )
                  : DitDoubleStackButton(
                      firstLabel: 'Resend',
                      secondLabel: 'Login',
                      onFirstPressed: () async {
                        context.read<ChildLoginProvider>().setOtpSent(false);
                        _otpFieldController.text = "123";
                        await onPressed(context);
                        _otpFieldController.text = "";
                      },
                      onSecondPressed: () async {
                        onPressed(context);
                      },
                    )
              : Container(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Future<void> onPressed(BuildContext context) async {
    FocusManager.instance.primaryFocus.unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await context.read<ChildLoginProvider>().loginChild();
      if (context.read<ChildLoginProvider>().loginSuccess == true) {
        List<Child> _children = context.read<ChildLoginProvider>().children;
        context.read<AppState>().setChildren(_children);
        Navigator.popAndPushNamed(context, RoutePath.child_home);
      }
    }
  }
}
