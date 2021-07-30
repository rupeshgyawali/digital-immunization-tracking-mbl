import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/text_field.dart';
import '../providers/child_search_provider.dart';
import '../repositories/child_repository.dart';
import 'local/child_list.dart';
import 'local/header_section.dart';

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
          backgroundColor: Color(0xFFDCDCDC),
          body: ListView(
            children: [
              HeaderSection(title: 'Child Search'),
              SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white),
                child: ChildSearchForm(),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  context.watch<ChildSearchProvider>().foundChildren.isNotEmpty
                      ? 'Found Children'
                      : '',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              context.watch<ChildSearchProvider>().foundChildren.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ChildrenList(
                        children:
                            context.watch<ChildSearchProvider>().foundChildren,
                      ),
                    )
                  : Container(),
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
        mainAxisAlignment: MainAxisAlignment.center,
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              '* denotes fields are required.',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey),
            ),
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
