import 'package:flutter/material.dart';

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class PoimenTheme {
  static final Color phoneColor = _colorFromHex('#A8DCFF');
  static final Color whatsappColor = _colorFromHex('#90EDB3');
  static final Color cardColor = _colorFromHex("#2A2A2A");

  static const Color textSecondary = Colors.grey;
}

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
  // MAIN COLORS
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: _colorFromHex('#242424'),
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,

  // TYPOGRAPHY & TEXT
  textTheme: const TextTheme(
    headline5: TextStyle(color: Colors.deepPurpleAccent),
  ),
  cardColor: _colorFromHex("#2A2A2A"),
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
  iconTheme: const IconThemeData(
    color: Colors.deepPurpleAccent,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _colorFromHex("#1A1A1A"),
    selectedItemColor: Colors.deepPurpleAccent,
    unselectedItemColor: Colors.grey,
  ),
  backgroundColor: const Color(0x00242424),
);
