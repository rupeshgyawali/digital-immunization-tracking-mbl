import 'package:flutter/material.dart';

class DitTextField extends StatelessWidget {
  final String label;
  final void Function(String value) onChanged;
  final Widget icon;

  const DitTextField({Key key, this.onChanged, this.label, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            this.label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.lightBlueAccent),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        TextField(
          onChanged: this.onChanged,
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              prefixIcon: this.icon,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class DitTextFormField extends StatelessWidget {
  final String label;
  final Widget icon;
  final void Function(String value) onSaved;
  final String Function(String value) validator;

  const DitTextFormField(
      {Key key, this.label, this.icon, this.onSaved, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            this.label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.lightBlueAccent),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        TextFormField(
          style: TextStyle(fontSize: 20),
          onSaved: this.onSaved,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: this.validator,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              prefixIcon: this.icon,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
