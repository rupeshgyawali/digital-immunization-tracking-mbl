import 'package:flutter/material.dart';

import '../models/child_model.dart';

class ChildHomeScreen extends StatelessWidget {
  final List<Child> children;

  const ChildHomeScreen({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(children.toString()),
      ),
    );
  }
}
