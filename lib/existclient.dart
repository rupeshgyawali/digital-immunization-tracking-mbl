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
          hintText: "Phone Number",
          hintStyle: TextStyle(
            fontSize: 20.0,
          ),
          icon: Icon(Icons.phone_android_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
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
          hintText: "Date of Birth(DOB)",
          hintStyle: TextStyle(
            fontSize: 20.0,
          ),
          icon: Icon(Icons.calendar_today_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
    );
    final myLoginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.lightBlueAccent,
      child: MaterialButton(
        minWidth: 250,
        padding: EdgeInsets.all(10),
        onPressed: () {
          if (phonenumber == "9876543210" && dateofbirth == "2020-12-6") {
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        phonenumberfield,
                        SizedBox(
                          height: 10,
                        ),
                        dateofbirthfield,
                        SizedBox(
                          height: 20,
                        ),
                        myLoginButton,
                      ],
                    )))));
  }
}
