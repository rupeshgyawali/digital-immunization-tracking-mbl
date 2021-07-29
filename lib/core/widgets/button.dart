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
    this.padding,
  }) : super(key: key);

  const DitButton.expanded({
    Key key,
    @required this.label,
    this.onPressed,
    Color color,
    TextStyle textStyle,
    this.padding,
  })  : this.color = color ?? Colors.white,
        this.textStyle = textStyle ?? defaultExpandedTextStyle,
        this.minWidth = double.infinity,
        super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Color color;
  final TextStyle textStyle;
  final double minWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(50.0),
      color: color ?? Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: minWidth,
        padding: padding ?? EdgeInsets.all(20),
        onPressed: onPressed,
        child: Text(label, style: textStyle, textAlign: TextAlign.center),
      ),
    );
  }
}

class DitDoubleStackButton extends StatelessWidget {
  const DitDoubleStackButton({
    Key key,
    @required this.firstLabel,
    @required this.secondLabel,
    this.onFirstPressed,
    this.onSecondPressed,
  }) : super(key: key);

  final String firstLabel;
  final String secondLabel;
  final void Function() onFirstPressed;
  final void Function() onSecondPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: DitButton(
              label: this.firstLabel,
              color: Colors.white,
              minWidth: MediaQuery.of(context).size.width / 2,
              textStyle:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              padding: EdgeInsets.all(25.0),
              onPressed: this.onFirstPressed,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: DitButton(
              label: this.secondLabel,
              minWidth: MediaQuery.of(context).size.width / 2,
              textStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              padding: EdgeInsets.all(25.0),
              onPressed: this.onSecondPressed,
            ),
          ),
        ],
      ),
    );
  }
}
