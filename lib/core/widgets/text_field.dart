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
  final void Function() onEditingComplete;
  final void Function(String) onChanged;
  final String Function(String value) validator;
  final TextEditingController controller;
  final GestureTapCallback onTap;
  final String initialValue;

  const DitTextFormField(
      {Key key,
      this.label,
      this.icon,
      this.onSaved,
      this.validator,
      this.controller,
      this.onTap,
      this.initialValue,
      this.onEditingComplete,
      this.onChanged})
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
          controller: this.controller,
          onSaved: this.onSaved,
          onTap: this.onTap,
          onEditingComplete: this.onEditingComplete,
          onChanged: this.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: this.validator,
          initialValue: this.initialValue,
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
