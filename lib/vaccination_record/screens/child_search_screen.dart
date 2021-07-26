import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_paths.dart';
import '../../core/widgets/text_field.dart';
import '../providers/child_search_provider.dart';
import '../repositories/child_repository.dart';

TextStyle myStyle = TextStyle(fontSize: 20);

class ChildSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChildSearchProvider(
        childRepository: context.read<ChildRepository>(),
      ),
      child: Consumer<ChildSearchProvider>(
        builder: (context, provider, child) => Scaffold(
          body: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Text(
                        "Enter the Phone No. and DOB of the child",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ChildSearchForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChildSearchForm extends StatefulWidget {
  @override
  _ChildSearchFormState createState() => _ChildSearchFormState();
}

class _ChildSearchFormState extends State<ChildSearchForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          context.watch<ChildSearchProvider>().hasError
              ? Center(
                  child: Text(
                    context.watch<ChildSearchProvider>().errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : Center(),
          DitTextFormField(
            label: 'Phone Number',
            icon: Icon(Icons.phone_android_outlined),
            onSaved: context.read<ChildSearchProvider>().setPhoneNo,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          DitTextFormField(
            label: 'Date of Birth',
            controller: _dateFieldController,
            icon: Icon(Icons.calendar_today_outlined),
            onSaved: context.read<ChildSearchProvider>().setDob,
            validator: MultiValidator([
              RequiredValidator(errorText: 'This field is required'),
              DateValidator('y/M/d',
                  errorText: 'Date must be in Year/Month/Day format'),
            ]),
            onTap: () {
              _selectDate(context);
            },
          ),
          !context.watch<ChildSearchProvider>().isLoading
              ? LoginButton(onPressed: () async {
                  FocusManager.instance.primaryFocus.unfocus();
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await context.read<ChildSearchProvider>().searchChild();
                    if (context.read<ChildSearchProvider>().searchSuccess ==
                        true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Child Found'),
                      ));
                      Navigator.pushNamed(
                        context,
                        RoutePath.child_details,
                        arguments:
                            context.read<ChildSearchProvider>().foundChild,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Child Not Found'),
                      ));
                    }
                  }
                })
              : Container(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    FocusManager.instance.primaryFocus.unfocus();
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime.now())
        .then(
      (value) => {
        if (value != null)
          {
            _dateFieldController.text =
                value.toString().split(' ')[0].replaceAll(RegExp(r'-'), '/')
          }
      },
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
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
