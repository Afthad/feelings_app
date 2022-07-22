import 'package:flutter/material.dart';

Widget textWidget(
    {required String text,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = 14,
    Color color = Colors.black,
    TextAlign textAlign = TextAlign.center}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
  );
}
