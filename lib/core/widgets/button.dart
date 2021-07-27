import 'package:flutter/material.dart';

const TextStyle defaultExpandedTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

class DitButton extends StatelessWidget {
  const DitButton({
    Key key,
    @required this.label,
    this.onPressed,
    this.color,
    this.textStyle,
    this.minWidth,
  }) : super(key: key);

  const DitButton.expanded({
    Key key,
    @required this.label,
    this.onPressed,
    Color color,
    TextStyle textStyle,
  })  : this.color = color ?? Colors.white,
        this.textStyle = textStyle ?? defaultExpandedTextStyle,
        this.minWidth = double.infinity,
        super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Color color;
  final TextStyle textStyle;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: color ?? Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: minWidth,
        padding: EdgeInsets.all(20),
        onPressed: onPressed,
        child: Text(label, style: textStyle),
      ),
    );
  }
}
