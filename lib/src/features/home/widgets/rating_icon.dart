import 'package:flutter/material.dart';

Widget buildIcon(double size, Color color) {
  return Container(
    height: 48,
    width: 48,
    alignment: Alignment.center,
    child: Icon(
      Icons.star,
      color: color,
      size: size,
    ),
  );
}
