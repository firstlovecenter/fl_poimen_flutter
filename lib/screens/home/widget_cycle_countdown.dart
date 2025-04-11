import 'package:flutter/material.dart';
import 'package:poimen/theme.dart';

class CycleCountdownWidget extends StatelessWidget {
  const CycleCountdownWidget({
    Key? key,
    required this.daysLeftInCycle,
    required this.daysInCycle,
  }) : super(key: key);

  final int daysLeftInCycle;
  final int daysInCycle;

  @override
  Widget build(BuildContext context) {
    // Calculate responsive sizes
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final baseDimension = isSmallScreen ? 120.0 : 140.0;

    // Calculate completed and remaining percentages
    final completedPercentage = ((daysInCycle - daysLeftInCycle) / daysInCycle * 100).toInt();
    final daysCompleted = daysInCycle - daysLeftInCycle;

    // Determine status color
    final Color statusColor = _setSemanticColour(daysLeftInCycle / daysInCycle);

    // Determine status message
    String statusMessage;
    if (daysLeftInCycle <= 7) {
      statusMessage = "Critical Stage";
    } else if (daysLeftInCycle <= 14) {
      statusMessage = "Action Needed";
    } else {
      statusMessage = "On Track";
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            // Title row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, size: 16, color: PoimenTheme.brand),
                const SizedBox(width: 8),
                const Text(
                  "Pastoral Cycle Progress",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: PoimenTheme.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Progress indicator and stats
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circular progress
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: baseDimension,
                      width: baseDimension,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey.shade200,
                        strokeWidth: 12,
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                        value: (daysInCycle - daysLeftInCycle) / daysInCycle,
                      ),
                    ),
                    // Center content
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$daysLeftInCycle',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                        const Text(
                          'days left',
                          style: TextStyle(
                            fontSize: 14,
                            color: PoimenTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Stats
                if (!isSmallScreen) ...[
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatRow('Total days:', '$daysInCycle days', Colors.grey.shade700),
                      const SizedBox(height: 8),
                      _buildStatRow('Completed:', '$daysCompleted days', Colors.green),
                      const SizedBox(height: 8),
                      _buildStatRow('Progress:', '$completedPercentage%', statusColor),
                      const SizedBox(height: 8),
                      _buildStatRow('Status:', statusMessage, statusColor),
                    ],
                  ),
                ],
              ],
            ),

            // Show these stats in a row for small screens
            if (isSmallScreen) ...[
              const SizedBox(height: 16),
              _buildStatRow('Total:', '$daysInCycle days', Colors.grey.shade700),
              const SizedBox(height: 4),
              _buildStatRow('Progress:', '$completedPercentage%', statusColor),
              const SizedBox(height: 4),
              _buildStatRow('Status:', statusMessage, statusColor),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: PoimenTheme.textSecondary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

Color _setSemanticColour(double value) {
  if (value < 0.25) {
    return Colors.red;
  } else if (value < 0.75) {
    return Colors.orange;
  } else {
    return Colors.green;
  }
}
