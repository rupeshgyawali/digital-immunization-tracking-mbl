import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_paths.dart';
import '../../core/widgets/button.dart';
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
          backgroundColor: Color(0xFFDCDCDC),
          body: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                      child: Text(
                        'LOGO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          'Child Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white),
                child: ChildSearchForm(),
              ),
              context.watch<ChildSearchProvider>().foundChildren.isNotEmpty
                  ? ChildrenList()
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

class ChildrenList extends StatelessWidget {
  const ChildrenList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Found Children',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...context
              .watch<ChildSearchProvider>()
              .foundChildren
              .map(
                (foundChild) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutePath.child_details,
                        arguments: foundChild,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 10,
                              backgroundImage: NetworkImage(
                                  "https://media.istockphoto.com/photos/doctor-giving-an-injection-vaccine-to-a-girl-little-girl-crying-with-picture-id1025414242?k=6&m=1025414242&s=612x612&w=0&h=NZVqNKu15qSleWuFERrzfvhK-JFvOdHef2bqJCrXKqY="),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    foundChild.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.cake_outlined, size: 16),
                                      Text(
                                        foundChild.dob,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.home_outlined, size: 16),
                                      Text(
                                        foundChild.temporaryAddr,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              height:
                                  MediaQuery.of(context).size.width / 5 - 10,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 50,
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
