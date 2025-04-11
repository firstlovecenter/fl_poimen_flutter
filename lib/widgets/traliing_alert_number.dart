import 'package:flutter/material.dart';

class TrailingCardAlertNumber extends StatelessWidget {
  const TrailingCardAlertNumber({Key? key, required this.number, required this.variant})
      : super(key: key);

  final int number;
  final TrailingCardAlertNumberVariant variant;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Define colors based on variant and theme
    Color backgroundColor;
    Color textColor;
    IconData? statusIcon;

    switch (variant) {
      case TrailingCardAlertNumberVariant.red:
        backgroundColor = isDark ? const Color(0x33FF5252) : const Color(0x22C02F2F);
        textColor = isDark ? const Color(0xFFFF5252) : const Color(0xFFC02F2F);
        statusIcon = Icons.warning_rounded;
        break;
      case TrailingCardAlertNumberVariant.green:
        backgroundColor = isDark ? const Color(0x3369F0AE) : const Color(0x2139C02F);
        textColor = isDark ? const Color(0xFF4CD551) : const Color(0xFF2E7D32);
        statusIcon = Icons.check_circle_outline;
        break;
      case TrailingCardAlertNumberVariant.black:
      default:
        backgroundColor = isDark ? Colors.grey.shade800.withOpacity(0.3) : Colors.grey.shade200;
        textColor = isDark ? Colors.grey.shade300 : Colors.grey.shade800;
        break;
    }

    // Determine whether to show an icon based on number
    final shouldShowIcon = number == 0 && variant == TrailingCardAlertNumberVariant.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (shouldShowIcon) ...[
            Icon(statusIcon, size: 16, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            '$number',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

enum TrailingCardAlertNumberVariant { red, black, green }
