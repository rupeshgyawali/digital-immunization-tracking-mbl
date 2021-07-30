import 'package:flutter/material.dart';

import '../models/child_model.dart';
import 'local/child_list.dart';
import 'local/header_section.dart';

class ChildHomeScreen extends StatelessWidget {
  final List<Child> children;

  const ChildHomeScreen({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCDCDC),
      body: ListView(
        children: [
          HeaderSection(title: 'Child Home'),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Children',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Children registered under your phone number are listed here.',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ChildrenList(children: children),
          ),
        ],
      ),
    );
  }
}
