import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                    ),
                    Text(
                      "Enter the Phone No. and DOB of the child",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    PhoneNumberField(),
                    SizedBox(
                      height: 10,
                    ),
                    DobField(),
                    SizedBox(
                      height: 20,
                    ),
                    !context.watch<ChildSearchProvider>().isLoading
                        ? LoginButton(onPressed: () async {
                            FocusManager.instance.primaryFocus.unfocus();
                            await context
                                .read<ChildSearchProvider>()
                                .searchChild();
                            if (context
                                    .read<ChildSearchProvider>()
                                    .searchSuccess ==
                                true) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Child Found'),
                              ));
                              // Navigator.pushNamed(
                              //     context, RoutePath.child_selection);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Child Not Found'),
                              ));
                            }
                          })
                        : Container(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        context.read<ChildSearchProvider>().setPhoneNo(val);
      },
      style: myStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: "Phone Number",
        hintStyle: TextStyle(
          fontSize: 20.0,
        ),
        icon: Icon(Icons.phone_android_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

class DobField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) {
        context.read<ChildSearchProvider>().setDob(val);
      },
      style: myStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: "Date of Birth(DOB)",
        hintStyle: TextStyle(
          fontSize: 20.0,
        ),
        icon: Icon(Icons.calendar_today_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
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
