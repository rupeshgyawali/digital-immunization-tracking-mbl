import 'package:flutter/material.dart';

import '../models/child_model.dart';

class ChildDetailsScreen extends StatelessWidget {
  final Child child;

  const ChildDetailsScreen({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(child.toString()),
      ),
    );
  }
}
