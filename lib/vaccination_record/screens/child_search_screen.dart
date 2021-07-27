import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_paths.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/header_clipper.dart';
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
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ChildSearchForm(),
                ),
              ),
            ],
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
              ? DitButton(
                  label: 'Search',
                  minWidth: 250,
                  textStyle: TextStyle(color: Colors.white, fontSize: 20),
                  onPressed: () async {
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

  Future<void> _selectDate(BuildContext context) async {
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
