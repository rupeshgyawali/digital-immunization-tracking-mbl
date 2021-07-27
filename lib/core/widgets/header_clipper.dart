import 'package:flutter/material.dart';

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    var firststartpoint = Offset(size.width / 10, size.height);
    var firstendpoint = Offset(size.width / 8 + size.width / 10, size.height);
    path.quadraticBezierTo(firststartpoint.dx, firststartpoint.dy,
        firstendpoint.dx, firstendpoint.dy);
    var secondstartpoint = Offset(size.width / 2, size.height);
    var secondendpoint = Offset(size.width, size.height - 110);
    path.quadraticBezierTo(secondstartpoint.dx, secondstartpoint.dy,
        secondendpoint.dx, secondendpoint.dy);
    var thirdstartpoint = Offset(size.width / 2, size.height);
    var thirdendpoint = Offset(size.width, size.height - 110);
    path.quadraticBezierTo(thirdstartpoint.dx, thirdstartpoint.dy,
        thirdendpoint.dx, thirdendpoint.dy);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
