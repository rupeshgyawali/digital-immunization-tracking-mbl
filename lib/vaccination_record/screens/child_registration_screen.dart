import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

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
                      DitTextField(
                        label: "Child Name",
                        icon: Icon(Icons.child_care_outlined),
                        onChanged:
                            context.read<ChildRegistrationProvider>().setName,
                      ),
                      DitTextField(
                        label: "Date of Birth",
                        icon: Icon(Icons.person_outline_outlined),
                        onChanged:
                            context.read<ChildRegistrationProvider>().setDob,
                      ),
                      DitTextField(
                        label: "Birth Place",
                        icon: Icon(Icons.person_outline_outlined),
                        onChanged: context
                            .read<ChildRegistrationProvider>()
                            .setBirthPlace,
                      ),
                      DitTextField(
                        label: "Father Name",
                        icon: Icon(Icons.person_outline_outlined),
                        onChanged: context
                            .read<ChildRegistrationProvider>()
                            .setFatherName,
                      ),
                      DitTextField(
                        label: "Mother Name",
                        icon: Icon(Icons.person_outline_outlined),
                        onChanged: context
                            .read<ChildRegistrationProvider>()
                            .setMotherName,
                      ),
                      DitTextField(
                        label: "Parent Phone Number",
                        icon: Icon(Icons.phone_android_outlined),
                        onChanged: context
                            .read<ChildRegistrationProvider>()
                            .setFatherPhn,
                      ),
                      AddressField(),
                      SizedBox(height: 10),
                      !context.watch<ChildRegistrationProvider>().isLoading
                          ? Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
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
                              ),
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

class AddressField extends StatefulWidget {
  @override
  _AddressFieldState createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  int selectedProvinceNo;
  String selectedDistrict;
  List<List<dynamic>> address;

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            "Address",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.lightBlueAccent),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 6.0,
                right: 0.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
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
                          selectedDistrict = null;
                        });
                      }
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.only(
                left: 6.0,
                right: 0.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Choose your district'),
                  value: selectedDistrict,
                  items: selectedProvinceNo != null
                      ? address[selectedProvinceNo - 1]
                          .sublist(1)
                          .map(
                            (e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList()
                      : null,
                  onChanged: (value) {
                    context
                        .read<ChildRegistrationProvider>()
                        .setTemporaryAddr(value);
                    setState(() {
                      selectedDistrict = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
