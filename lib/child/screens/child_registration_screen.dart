import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_paths.dart';
import '../../core/routes/router.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/local_address_field.dart';
import '../../core/widgets/text_field.dart';
import '../providers/child_registration_provider.dart';
import '../repositories/child_repository.dart';

class ChildRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChildRegistrationProvider(
        childRepository: context.read<ChildRepository>(),
      ),
      child: Consumer<ChildRegistrationProvider>(
        builder: (context, provider, child) => Scaffold(
          backgroundColor: Color(0xFFDCDCDC),
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: CloseButton(
                color: Colors.black87,
              ),
            ),
            title: Text(
              "Child Register",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: ChildRegistrationForm(),
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

  int currentStep;
  bool complete;

  void next() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      currentStep != 3
          ? goTo(currentStep + 1)
          : setState(() {
              complete = true;
            });
    }
  }

  void cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  void goTo(int step) {
    setState(() {
      currentStep = step;
    });
  }

  @override
  void initState() {
    currentStep = 0;
    complete = false;
    super.initState();
  }

  @override
  void dispose() {
    _dateFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Theme(
        data: ThemeData(
          canvasColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepContinue: next,
          onStepCancel: cancel,
          onStepTapped: (step) => goTo(step),
          steps: [
            Step(
              title: const Text(''),
              isActive: currentStep >= 0,
              content: NameDobAndBirthPlaceField(
                  dateFieldController: _dateFieldController),
            ),
            Step(
              title: const Text(''),
              isActive: currentStep >= 1,
              content: FatherAndMotherNameField(),
            ),
            Step(
              title: const Text(''),
              isActive: currentStep >= 2,
              content: FatherAndMotherPhoneNoField(),
            ),
            Step(
              title: const Text(''),
              isActive: currentStep >= 3,
              content: TemporaryAndPermanentAddressField(),
            ),
          ],
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return !context.watch<ChildRegistrationProvider>().isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 50.0),
                    child: DitDoubleStackButton(
                      firstLabel: 'Previous',
                      secondLabel: 'Next',
                      onFirstPressed: onStepCancel,
                      onSecondPressed: () async {
                        onPressed(context);
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
          },
        ),
      ),
    );
  }

  Future<void> onPressed(BuildContext context) async {
    next();
    if (complete == false) return;

    FocusManager.instance.primaryFocus.unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await context.read<ChildRegistrationProvider>().registerChild();
      if (context.read<ChildRegistrationProvider>().registrationSuccess ==
          true) {
        Navigator.popAndPushNamed(
          context,
          RoutePath.child_details,
          arguments: ChildVaccineRecordRouteArgument(
              context.read<ChildRegistrationProvider>().newChild),
        );
      }
    }
  }
}

class NameDobAndBirthPlaceField extends StatelessWidget {
  final TextEditingController dateFieldController;

  const NameDobAndBirthPlaceField({Key key, @required this.dateFieldController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 100.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: kElevationToShadow[2]),
      child: Column(
        children: [
          DitTextFormField(
            label: "Child Name",
            icon: Icon(Icons.child_care_outlined),
            initialValue: context.read<ChildRegistrationProvider>().name,
            onSaved: context.read<ChildRegistrationProvider>().setName,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          SizedBox(height: 10.0),
          DitTextFormField(
            label: "Date of Birth",
            controller: dateFieldController,
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
          SizedBox(height: 10.0),
          DitTextFormField(
            label: "Birth Place",
            icon: Icon(Icons.person_outline_outlined),
            initialValue: context.read<ChildRegistrationProvider>().birthPlace,
            // onChanged: context.read<ChildRegistrationProvider>().setBirthPlace,
            onSaved: context.read<ChildRegistrationProvider>().setBirthPlace,
            validator: RequiredValidator(errorText: 'This field is required'),
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
            dateFieldController.text =
                value.toString().split(' ')[0].replaceAll(RegExp(r'-'), '/')
          }
      },
    );
  }
}

class FatherAndMotherNameField extends StatelessWidget {
  const FatherAndMotherNameField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 100.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: kElevationToShadow[2]),
      child: Column(
        children: [
          DitTextFormField(
            label: "Father Name",
            icon: Icon(Icons.person_outline_outlined),
            initialValue: context.read<ChildRegistrationProvider>().fatherName,
            onSaved: context.read<ChildRegistrationProvider>().setFatherName,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          SizedBox(height: 10.0),
          DitTextFormField(
            label: "Mother Name",
            icon: Icon(Icons.person_outline_outlined),
            initialValue: context.read<ChildRegistrationProvider>().motherName,
            onSaved: context.read<ChildRegistrationProvider>().setMotherName,
            validator: RequiredValidator(errorText: 'This field is required'),
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
        ],
      ),
    );
  }
}

class FatherAndMotherPhoneNoField extends StatelessWidget {
  const FatherAndMotherPhoneNoField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 100.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: kElevationToShadow[2]),
      child: Column(
        children: [
          DitTextFormField(
            label: "Father Phone Number",
            icon: Icon(Icons.phone_android_outlined),
            initialValue: context.read<ChildRegistrationProvider>().fatherPhn,
            onSaved: context.read<ChildRegistrationProvider>().setFatherPhn,
            validator: RequiredValidator(errorText: 'This field is required'),
          ),
          SizedBox(height: 10.0),
          DitTextFormField(
            label: "Mother Phone Number",
            icon: Icon(Icons.phone_android_outlined),
            initialValue: context.read<ChildRegistrationProvider>().motherPhn,
            onSaved: context.read<ChildRegistrationProvider>().setMotherPhn,
            validator: RequiredValidator(errorText: 'This field is required'),
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
        ],
      ),
    );
  }
}

class TemporaryAndPermanentAddressField extends StatelessWidget {
  const TemporaryAndPermanentAddressField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 100.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: kElevationToShadow[2]),
      child: Theme(
        data: ThemeData(canvasColor: Colors.white),
        child: Column(
          children: [
            LocalAddressField(
              label: "Temporary Address",
              isRequired: true,
              initialValue:
                  context.read<ChildRegistrationProvider>().temporaryAddr,
              onSaved:
                  context.read<ChildRegistrationProvider>().setTemporaryAddr,
            ),
            SizedBox(height: 10.0),
            LocalAddressField(
              label: "Permanent Address",
              initialValue:
                  context.read<ChildRegistrationProvider>().permanentAddr,
              onSaved:
                  context.read<ChildRegistrationProvider>().setPermanentAddr,
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
          ],
        ),
      ),
    );
  }
}
