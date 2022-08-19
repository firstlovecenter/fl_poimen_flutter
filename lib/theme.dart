import 'package:flutter/material.dart';

var lightTheme = ThemeData(
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.black87,
  ),
  primaryColor: Colors.purple,
  textTheme: const TextTheme(
    bodyText1: TextStyle(fontSize: 18),
    bodyText2: TextStyle(fontSize: 16),
    button: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: Colors.grey,
    ),
  ),
  buttonTheme: const ButtonThemeData(),
);

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.purple,
  backgroundColor: const Color(0x00242424),
);
