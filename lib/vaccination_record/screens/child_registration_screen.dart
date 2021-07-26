import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_paths.dart';
import '../../core/widgets/local_address_field.dart';
import '../../core/widgets/text_field.dart';
import '../providers/child_registration_provider.dart';
import '../repositories/child_repository.dart';

TextStyle myStyle = TextStyle(fontSize: 20);

class ChildRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChildRegistrationProvider(
        childRepository: context.read<ChildRepository>(),
      ),
      child: Consumer<ChildRegistrationProvider>(
        builder: (context, provider, child) => Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "CHILD REGISTRATION",
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ChildRegistrationForm(),
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

class ChildRegistrationForm extends StatefulWidget {
  @override
  _ChildRegistrationFormState createState() => _ChildRegistrationFormState();
}

class _ChildRegistrationFormState extends State<ChildRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          context.watch<ChildRegistrationProvider>().hasError
              ? Center(
                  child: Text(
                    context.watch<ChildRegistrationProvider>().errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : Center(),
          DitTextFormField(
            label: "Child Name",
            icon: Icon(Icons.child_care_outlined),
            onSaved: context.read<ChildRegistrationProvider>().setName,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          DitTextFormField(
            label: "Date of Birth",
            controller: _dateFieldController,
            icon: Icon(Icons.person_outline_outlined),
            onSaved: context.read<ChildRegistrationProvider>().setDob,
            validator: MultiValidator([
              RequiredValidator(errorText: 'This field is required'),
              DateValidator('y/M/d',
                  errorText: 'Date must be in Year/Month/Day format'),
            ]),
            onTap: () {
              _selectDate(context);
            },
          ),
          DitTextFormField(
            label: "Birth Place",
            icon: Icon(Icons.person_outline_outlined),
            onSaved: context.read<ChildRegistrationProvider>().setBirthPlace,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          DitTextFormField(
            label: "Father Name",
            icon: Icon(Icons.person_outline_outlined),
            onSaved: context.read<ChildRegistrationProvider>().setFatherName,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          DitTextFormField(
            label: "Mother Name",
            icon: Icon(Icons.person_outline_outlined),
            onSaved: context.read<ChildRegistrationProvider>().setMotherName,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          DitTextFormField(
            label: "Father Phone Number",
            icon: Icon(Icons.phone_android_outlined),
            onSaved: context.read<ChildRegistrationProvider>().setFatherPhn,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          DitTextFormField(
            label: "Mother Phone Number",
            icon: Icon(Icons.phone_android_outlined),
            onSaved: context.read<ChildRegistrationProvider>().setMotherPhn,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          LocalAddressField(
            label: "Temporary Address",
            onSaved: (localAddress) {
              context
                  .read<ChildRegistrationProvider>()
                  .setTemporaryAddr(localAddress.toString());
            },
          ),
          LocalAddressField(
            label: "Permanent Address",
            onSaved: (localAddress) {
              context
                  .read<ChildRegistrationProvider>()
                  .setPermanentAddr(localAddress.toString());
            },
          ),
          SizedBox(height: 10),
          !context.watch<ChildRegistrationProvider>().isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async {
                      FocusManager.instance.primaryFocus.unfocus();
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        await context
                            .read<ChildRegistrationProvider>()
                            .registerChild();
                        if (context
                                .read<ChildRegistrationProvider>()
                                .registrationSuccess ==
                            true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Registration Successfull"),
                            ),
                          );
                          Navigator.pushNamed(
                            context,
                            RoutePath.child_details,
                            arguments: context
                                .read<ChildRegistrationProvider>()
                                .newChild,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: const Text("Registration Failed")),
                          );
                        }
                      }
                    },
                  ),
                )
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
