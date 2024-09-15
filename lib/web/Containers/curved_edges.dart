import 'package:flutter/material.dart';

class CustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstcurves = Offset(0, size.height - 20);
    final lastcurves = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstcurves.dx, firstcurves.dy, lastcurves.dx, lastcurves.dy);


    final secoundcurves = Offset(0, size.height - 20);
    final secoundlastcurves = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secoundcurves.dx, secoundcurves.dy,
        secoundlastcurves.dx, secoundlastcurves.dy);



    final thirdcurves = Offset(size.width, size.height - 20);
    final thirdlastcurves = Offset(size.width, size.height);
    path.quadraticBezierTo(
        thirdcurves.dx, thirdcurves.dy, thirdlastcurves.dx, thirdlastcurves.dy);


    path.lineTo(size.width,0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
