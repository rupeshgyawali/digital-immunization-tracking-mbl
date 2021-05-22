import '../../core/routes/route_paths.dart';
import 'package:flutter/material.dart';

class ChildSelectionScreen extends StatelessWidget {
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
                    heroTag: 'btn_new_child',
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
                          'New Child Registration',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {},
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
                    heroTag: 'btn_existing_child',
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
                          'Existing Child',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePath.child_search);
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
