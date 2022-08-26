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
    headline5: TextStyle(color: Colors.redAccent),
    subtitle1: TextStyle(
      color: Colors.grey,
    ),
  ),
  buttonTheme: const ButtonThemeData(),
);

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    headline5: TextStyle(color: Colors.deepPurpleAccent),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.deepPurpleAccent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 13, bottom: 13),
      primary: Colors.deepPurple,
      textStyle: const TextStyle(fontSize: 18),
    ),
  ),
  backgroundColor: const Color(0x00242424),
);
