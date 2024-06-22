import 'package:poimen/theme.dart';
import 'package:flutter/material.dart';

var newLightTheme = ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: PoimenTheme.brand));

var lightTheme = ThemeData(
  // MAIN COLORS
  scaffoldBackgroundColor: colorFromHex('#F0F0F0'),
  visualDensity: VisualDensity.adaptivePlatformDensity,

  // TYPOGRAPHY & TEXT
  textTheme: TextTheme(
    headlineSmall: TextStyle(color: PoimenTheme.brand),
  ),
  cardColor: colorFromHex("#FDFDFD"),

  buttonTheme: ButtonThemeData(
    buttonColor: PoimenTheme.brand,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 13, bottom: 13),
      // backgroundColor: PoimenTheme.brand,
      textStyle: const TextStyle(fontSize: 18),
    ),
  ),
  iconTheme: IconThemeData(
    color: PoimenTheme.brand,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: colorFromHex("#FDFDFD"),
    selectedItemColor: PoimenTheme.brand,
    unselectedItemColor: Colors.grey,
  ),
  appBarTheme: AppBarTheme(
    color: colorFromHex("#FDFDFD"),
    elevation: 0,
    iconTheme: IconThemeData(
      color: PoimenTheme.brand,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: MaterialColor(PoimenTheme.brand.value, PoimenTheme.brands),
  ).copyWith(surface: const Color(0x00242424)),
);

var darkTheme = ThemeData(
  // MAIN COLORS
  scaffoldBackgroundColor: colorFromHex('#1E1E1E'),
  visualDensity: VisualDensity.adaptivePlatformDensity,

  // TYPOGRAPHY & TEXT
  textTheme: TextTheme(
    headlineSmall: TextStyle(color: PoimenTheme.brand),
  ),
  cardColor: colorFromHex("#2A2A2A"),
  buttonTheme: ButtonThemeData(
    buttonColor: PoimenTheme.brand,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 13, bottom: 13),
      // backgroundColor: PoimenTheme.brand,
      textStyle: const TextStyle(fontSize: 18, color: Colors.white),
    ),
  ),
  iconTheme: IconThemeData(
    color: PoimenTheme.brand,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: colorFromHex("#1A1A1A"),
    selectedItemColor: PoimenTheme.brand,
    unselectedItemColor: Colors.grey,
  ),
  appBarTheme: AppBarTheme(
    color: colorFromHex("#1A1A1A"),
    iconTheme: IconThemeData(
      color: PoimenTheme.brand,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: MaterialColor(PoimenTheme.brand.value, PoimenTheme.brands),
  ).copyWith(
    surface: const Color(0x00242424),
  ),
);
