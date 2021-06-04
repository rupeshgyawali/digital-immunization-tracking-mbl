import 'package:digital_immunization_tracking/child.dart';
import 'package:flutter/material.dart';

class NewClient extends StatefulWidget {
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    color: Colors.white,
                    child: Column(children: [
                      Container(
                        width: (MediaQuery.of(context).size.width),
                        height: (MediaQuery.of(context).size.height),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.white70, BlendMode.dstATop),
                              image: NetworkImage(
                                  'https://pointville.ag/wp-content/uploads/2018/07/vaccines-syringe-generic.jpg')),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 40, left: 20, right: 20, bottom: 300),
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(0.4)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
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
                      ),
                    ])))));
  }
}
