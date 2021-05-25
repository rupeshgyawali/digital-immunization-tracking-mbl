import 'package:digital_immunization_tracking/newclient.dart';
import 'package:flutter/material.dart';
import 'package:digital_immunization_tracking/existclient.dart';

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: (MediaQuery.of(context).size.width),
                  height: 250,
                  child: FloatingActionButton(
                    backgroundColor: Colors.lightBlueAccent,
                    elevation: 0.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle_outline_rounded,
                          size: 100,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'New Client Registration',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NewClient()));
                    },
                  ),
                  decoration: BoxDecoration(color: Colors.lightBlueAccent),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: (MediaQuery.of(context).size.width),
                  height: 250,
                  child: FloatingActionButton(
                    backgroundColor: Colors.lightBlueAccent,
                    elevation: 0.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download_sharp,
                          size: 100,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Existing Client',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExistClient()));
                    },
                  ),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
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
