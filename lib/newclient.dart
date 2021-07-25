import 'package:digital_immunization_tracking/childdetails3.dart';
import 'package:flutter/material.dart';

class NewClient extends StatefulWidget {
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  String childname;
  String fathername;
  String mothername;
  String parentphonenumber;
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    final myLoginButton = Material(
      color: Colors.lightBlueAccent.withOpacity(0.5),
      child: MaterialButton(
        padding: EdgeInsets.only(left: 7.0, right: 7.0),
        minWidth: 50,
        onPressed: () {
          if (childname == "David" &&
              fathername == "John" &&
              mothername == "Lily" &&
              parentphonenumber == "9876543210") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChildDetails3()));
          } else {
            print("Error");
          }
        },
        child: Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width),
                  height: (MediaQuery.of(context).size.height),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.white70, BlendMode.dstATop),
                        image: NetworkImage(
                            'https://www.healthsmartvaccines.com/wp-content/uploads/2016/01/Vaccines.jpg')),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 40, left: 10, right: 10, bottom: 0),
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.4)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Child Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.child_care_outlined,
                                  color: Colors.blueGrey,
                                ),
                                hintText: "Child Name",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.blueGrey,
                                ),
                                hintText: "Father Name",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.blueGrey,
                                ),
                                hintText: "Mother Name",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.phone_android_outlined,
                                  color: Colors.blueGrey,
                                ),
                                hintText: "Parent Phone Number",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: FractionalOffset(0.03, 0.0),
                        child: Text(
                          "ADDRESS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: FractionalOffset(0.97, 0.0),
                        child: MaterialButton(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          color: Colors.lightBlueAccent.withOpacity(0.5),
                          minWidth: 70,
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime(2021))
                                .then((date) {
                              setState(() {
                                _dateTime = date;
                              });
                            });
                          },
                          child: Text(
                            'Pick a date',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset(0.03, 0.0),
                        child: Container(
                          height: 30,
                          width: 120,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (value) => (value),
                              hint: Text("Province",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: FractionalOffset(0.03, 0.0),
                        child: Container(
                          height: 30,
                          width: 120,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              onChanged: (value) => (value),
                              hint: Text("District",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: FractionalOffset(0.03, 0.0),
                        child: Container(
                          height: 30,
                          width: 120,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (value) => (value),
                              hint: Text("Mun/Vdc",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: FractionalOffset(0.03, 0.0),
                        child: Container(
                          height: 30,
                          width: 120,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (value) => (value),
                              hint: Text("Ward",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 70),
                      myLoginButton,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
