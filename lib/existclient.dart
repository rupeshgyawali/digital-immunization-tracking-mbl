import 'package:flutter/material.dart';
import 'package:digital_immunization_tracking/childdetails1.dart';

TextStyle myStyle = TextStyle(fontSize: 20);

class ExistClient extends StatefulWidget {
  @override
  _ExistClientState createState() => _ExistClientState();
}

class _ExistClientState extends State<ExistClient> {
  String phonenumber;
  String dateofbirth;
  @override
  Widget build(BuildContext context) {
    final phonenumberfield = TextField(
      onChanged: (val) {
        setState(() {
          phonenumber = val;
        });
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          icon: Icon(Icons.phone_android_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final dateofbirthfield = TextField(
      onChanged: (val) {
        setState(() {
          dateofbirth = val;
        });
      },
      style: myStyle,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          icon: Icon(Icons.calendar_today_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final myLoginButton = Material(
      elevation: 5.0,
      color: Colors.lightBlueAccent,
      child: MaterialButton(
        minWidth: 250,
        padding: EdgeInsets.all(10),
        onPressed: () {
          if (phonenumber == "" && dateofbirth == "") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChildDetails1()));
          } else {
            print("Incorrect details");
          }
        },
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: Container(
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Align(
                        alignment: FractionalOffset(0.22, 0.0),
                        child: Container(
                          child: Text(
                            "Phone Number",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      phonenumberfield,
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: FractionalOffset(0.25, 0.0),
                        child: Container(
                          child: Text(
                            "Date of Birth(DOB)",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      dateofbirthfield,
                      SizedBox(
                        height: 20,
                      ),
                      myLoginButton,
                    ],
                  )))),
    ));
  }
}
