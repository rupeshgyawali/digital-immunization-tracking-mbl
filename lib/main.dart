import 'package:flutter/material.dart';

void main() {
  runApp(DigitalImmunizationTrackingApp());
}

class DigitalImmunizationTrackingApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Immunization Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Text('Hello World!'),
    );
  }
}
