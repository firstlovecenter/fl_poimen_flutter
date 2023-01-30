import 'package:flutter/material.dart';

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

class PoimenTheme {
  static const Color phoneColor = Color(0xFFA8DCFF);
  static const Color whatsappColor = Color(0xFF90EDB3);

  static const Color darkCardColor = Color(0xFF2A2A2A);
  static const Color lightCardColor = Color.fromRGBO(217, 217, 217, 1);

  static const Color white = Color(0xFFFFFFFF);
  static const Color textSecondary = Colors.grey;
  static Color brand = _colorFromHex('#850035');
  static Color brandTextPrimary = _colorFromHex('#8a3a59');

  static TextStyle heading2 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static Map<int, Color> brands = {
    50: _colorFromHex('#FEEAFD'),
    100: _colorFromHex('#FDCDFB'),
    200: _colorFromHex('#FBAFF8'),
    300: _colorFromHex('#F98FF6'),
    400: _colorFromHex('#F770F3'),
    500: _colorFromHex('#F550F1'),
    600: _colorFromHex('#F331EE'),
    700: _colorFromHex('#F111EC'),
    800: _colorFromHex('#EE00E9'),
    900: _colorFromHex('#E900E7'),
  };

  static Color darkBrand = _colorFromHex('#45001C');
  static Color bad = _colorFromHex('#F44A4A');
  static Color good = _colorFromHex('#39FF14');
  static Color warning = Colors.yellow;
}

var lightTheme = ThemeData(
  // MAIN COLORS
  primarySwatch: MaterialColor(PoimenTheme.brand.value, PoimenTheme.brands),
  scaffoldBackgroundColor: _colorFromHex('#F0F0F0'),
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,

  // TYPOGRAPHY & TEXT
  textTheme: TextTheme(
    headline5: TextStyle(color: PoimenTheme.brand),
  ),
  cardColor: _colorFromHex("#FDFDFD"),
  buttonTheme: ButtonThemeData(
    buttonColor: PoimenTheme.brand,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 13, bottom: 13),
      backgroundColor: PoimenTheme.brand,
      textStyle: const TextStyle(fontSize: 18),
    ),
  ),
  iconTheme: IconThemeData(
    color: PoimenTheme.brand,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _colorFromHex("#FDFDFD"),
    selectedItemColor: PoimenTheme.brand,
    unselectedItemColor: Colors.grey,
  ),
  backgroundColor: const Color(0x00242424),
);

var darkTheme = ThemeData(
  // MAIN COLORS
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: _colorFromHex('#1E1E1E'),
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,

  // TYPOGRAPHY & TEXT
  textTheme: TextTheme(
    headline5: TextStyle(color: PoimenTheme.brand),
  ),
  cardColor: _colorFromHex("#2A2A2A"),
  buttonTheme: ButtonThemeData(
    buttonColor: PoimenTheme.brand,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 13, bottom: 13),
      backgroundColor: PoimenTheme.brand,
      textStyle: const TextStyle(fontSize: 18),
    ),
  ),
  iconTheme: IconThemeData(
    color: PoimenTheme.brand,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _colorFromHex("#1A1A1A"),
    selectedItemColor: PoimenTheme.brand,
    unselectedItemColor: Colors.grey,
  ),
  backgroundColor: const Color(0x00242424),
);
