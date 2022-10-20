import 'package:flutter/material.dart';

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class PoimenTheme {
  static const Color phoneColor = Color(0xFFA8DCFF);
  static const Color whatsappColor = Color(0xFF90EDB3);

  static const Color darkCardColor = Color(0xFF2A2A2A);
  static const Color lightCardColor = Color.fromARGB(255, 217, 217, 217);

  static const Color white = Color(0xFFFFFFFF);
  static const Color textSecondary = Colors.grey;
  static Color brand = _colorFromHex('#611ABB');
  static Color bad = _colorFromHex('#F44A4A');
  static Color good = _colorFromHex('#39FF14');
  static Color warning = Colors.yellow;
}

var lightTheme = ThemeData(
  // MAIN COLORS
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: _colorFromHex('#F0F0F0'),
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,

  // TYPOGRAPHY & TEXT
  textTheme: TextTheme(
    headline5: TextStyle(color: PoimenTheme.brand),
  ),
  cardColor: _colorFromHex("#FDFDFD"),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.deepPurpleAccent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 13, bottom: 13),
      backgroundColor: Colors.deepPurple,
      textStyle: const TextStyle(fontSize: 18),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.deepPurpleAccent,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _colorFromHex("#FDFDFD"),
    selectedItemColor: Colors.deepPurpleAccent,
    unselectedItemColor: Colors.grey,
  ),
  backgroundColor: const Color(0x00242424),
);

var darkTheme = ThemeData(
  // MAIN COLORS
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: _colorFromHex('#1E1E1E'),
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,

  // TYPOGRAPHY & TEXT
  textTheme: TextTheme(
    headline5: TextStyle(color: PoimenTheme.brand),
  ),
  cardColor: _colorFromHex("#2A2A2A"),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.deepPurpleAccent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 13, bottom: 13),
      backgroundColor: Colors.deepPurple,
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
