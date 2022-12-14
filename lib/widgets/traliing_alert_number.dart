import 'package:flutter/material.dart';

class TrailingCardAlertNumber extends StatelessWidget {
  const TrailingCardAlertNumber({Key? key, required this.number, required this.variant})
      : super(key: key);

  final int number;
  final TrailingCardAlertNumberVariant variant;

  @override
  Widget build(BuildContext context) {
    Color cardBackground = const Color(0xff000000);
    Color textColor = Colors.red;

    if (variant == TrailingCardAlertNumberVariant.red) {
      cardBackground = const Color(0x22C02F2F);
    }

    if (variant == TrailingCardAlertNumberVariant.green) {
      cardBackground = const Color(0x2139C02F);
      textColor = const Color(0xFF4CD551);
    }

    return Card(
      color: cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
        child: Text(
          '$number',
          style: TextStyle(color: textColor, fontSize: 15),
        ),
      ),
    );
  }
}

enum TrailingCardAlertNumberVariant { red, black, green }
