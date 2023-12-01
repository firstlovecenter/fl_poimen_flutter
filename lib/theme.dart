import 'dart:math';

import 'package:flutter/material.dart';

Color colorFromHex(String hexColor) {
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
  static Color brand = colorFromHex('#850035');
  static Color brandTextPrimary = colorFromHex('#8a3a59');

  static TextStyle heading1 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle heading2 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static Map<int, Color> brands = {
    50: colorFromHex('#FEEAFD'),
    100: colorFromHex('#FDCDFB'),
    200: colorFromHex('#FBAFF8'),
    300: colorFromHex('#F98FF6'),
    400: colorFromHex('#F770F3'),
    500: colorFromHex('#F550F1'),
    600: colorFromHex('#F331EE'),
    700: colorFromHex('#F111EC'),
    800: colorFromHex('#EE00E9'),
    900: colorFromHex('#E900E7'),
  };

  static Map<int, Color> facebook = {
    50: colorFromHex('#E8F4F9'),
    100: colorFromHex('#D9DEE9'),
    200: colorFromHex('#B7C2DA'),
    300: colorFromHex('#6482C0'),
    400: colorFromHex('#4267B2'),
    500: colorFromHex('#385898'),
    600: colorFromHex('#314E89'),
    700: colorFromHex('#29487D'),
    800: colorFromHex('#223B67'),
    900: colorFromHex('#1E355B'),
  };

  List<Color> randomColorArray = [
    colorFromHex('#FEB2B2'),
    colorFromHex('#FBD38D'),
    colorFromHex('#FAF089'),
    colorFromHex('#9AE6B4'),
    colorFromHex('#81E6D9'),
    colorFromHex('#90cdf4'),
    colorFromHex('#9DECF9'),
    colorFromHex('#D6BCFA'),
    colorFromHex('#FBB6CE'),
    colorFromHex('#9BDAF3'),
    colorFromHex('#B7C2DA'),
    colorFromHex('#A2CDFF'),
    colorFromHex('#90edb3'),
    colorFromHex('#A8DCFA'),
    colorFromHex('#A2D4EC'),
  ];

  static Color darkBrand = colorFromHex('#45001C');
  static Color bad = colorFromHex('#F44A4A');
  static Color good = colorFromHex('#39FF14');
  static Color warning = Colors.yellow;

  Color getRandomColor() {
    return randomColorArray[Random().nextInt(randomColorArray.length)];
  }
}
