import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import '../providers/child_registration_provider.dart';
import '../repositories/child_repository.dart';

TextStyle myStyle = TextStyle(fontSize: 20);

class ChildRegistrationScreen extends StatefulWidget {
  @override
  _ChildRegistrationScreenState createState() =>
      _ChildRegistrationScreenState();
}

class _ChildRegistrationScreenState extends State<ChildRegistrationScreen> {
  int selectedProvinceNo;
  List<List<dynamic>> address;
  bool disableddropdown = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String csvString = await rootBundle.loadString('assets/address.csv');
      setState(() {
        address = CsvToListConverter().convert(csvString);
      });
    });
  }

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
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "CHILD REGISTER",
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Align(
                        alignment: FractionalOffset(0.22, 0.0),
                        child: Container(
                          child: Text(
                            "Child Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      ChildNameField(),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: FractionalOffset(0.22, 0.0),
                        child: Container(
                          child: Text(
                            "Date of Birth",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      DobField(),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: FractionalOffset(0.22, 0.0),
                        child: Container(
                          child: Text(
                            "Birth Place",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      BirthPlaceFeild(),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: FractionalOffset(0.22, 0.0),
                        child: Container(
                          child: Text(
                            "Father Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      FatherNameFiled(),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: FractionalOffset(0.22, 0.0),
                        child: Container(
                          child: Text(
                            "Mother Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      MotherNameField(),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: FractionalOffset(0.22, 0.0),
                        child: Container(
                          child: Text(
                            "Parent Phone Number",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      ParentPhoneNumberField(),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: FractionalOffset(0.03, 0.0),
                          child: Container(
                            child: Text(
                              "ADDRESS",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: FractionalOffset(0.03, 0.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 6.0,
                            right: 0.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text('Choose your province'),
                              value: selectedProvinceNo != null
                                  ? address[selectedProvinceNo - 1][0]
                                  : null,
                              items: address != null
                                  ? address
                                      .map(
                                        (province) => DropdownMenuItem<String>(
                                          child: Text(province[0]),
                                          value: province[0],
                                        ),
                                      )
                                      .toList()
                                  : null,
                              onChanged: (value) {
                                address.asMap().forEach((i, element) {
                                  if (element.indexOf(value) != -1) {
                                    setState(() {
                                      selectedProvinceNo = i + 1;
                                    });
                                  }
                                  disableddropdown = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: FractionalOffset(0.03, 0.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 6.0,
                            right: 0.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text('District'),
                              value: context
                                  .watch<ChildRegistrationProvider>()
                                  .temporaryAddr,
                              items: selectedProvinceNo != null
                                  ? address[selectedProvinceNo - 1]
                                      .map(
                                        (e) => DropdownMenuItem<String>(
                                          child: Text(e),
                                          value: e,
                                        ),
                                      )
                                      .toList()
                                  : null,
                              onChanged: disableddropdown
                                  ? null
                                  : (value) {
                                      context
                                          .read<ChildRegistrationProvider>()
                                          .setTemporaryAddr(value);
                                    },
                            ),
                          ),
                        ),
                      ),
                      !context.watch<ChildRegistrationProvider>().isLoading
                          ? ElevatedButton(
                              child: Text('Register'),
                              onPressed: () async {
                                FocusManager.instance.primaryFocus.unfocus();
                                await context
                                    .read<ChildRegistrationProvider>()
                                    .registerChild();
                                if (context
                                        .read<ChildRegistrationProvider>()
                                        .registrationSuccess ==
                                    true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          "Registration Successfull"),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          const Text("Registration Failed"),
                                    ),
                                  );
                                }
                              },
                            )
                          : Container(
                              child: CircularProgressIndicator(),
                            ),
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

class ChildNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        context.read<ChildRegistrationProvider>().setName(val);
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          icon: Icon(Icons.child_care_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}

class FatherNameFiled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        context.read<ChildRegistrationProvider>().setFatherName(val);
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          icon: Icon(Icons.person_outline_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}

class MotherNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        context.read<ChildRegistrationProvider>().setMotherName(val);
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          icon: Icon(Icons.person_outline_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}

class ParentPhoneNumberField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        context.read<ChildRegistrationProvider>().setFatherPhn(val);
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          icon: Icon(Icons.phone_android_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}

class DobField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        context.read<ChildRegistrationProvider>().setDob(val);
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          icon: Icon(Icons.person_outline_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}

class BirthPlaceFeild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        context.read<ChildRegistrationProvider>().setBirthPlace(val);
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          icon: Icon(Icons.person_outline_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}
