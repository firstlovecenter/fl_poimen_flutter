import 'package:flutter/material.dart';

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
    const sizedBoxDimensions = 110.0;

    return Stack(
      children: [
        SizedBox(
          height: sizedBoxDimensions,
          width: sizedBoxDimensions * 1.05,
          child: CircularProgressIndicator(
            backgroundColor: const Color.fromARGB(91, 158, 158, 158),
            strokeWidth: 15,
            valueColor:
                AlwaysStoppedAnimation<Color?>(_setSemanticColour(daysLeftInCycle / daysInCycle)),
            value: (daysInCycle - daysLeftInCycle) / daysInCycle,
          ),
        ),
        SizedBox(
          height: sizedBoxDimensions,
          width: sizedBoxDimensions * 1.05,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$daysLeftInCycle days', style: const TextStyle(fontSize: 16)),
              const Text('left in cycle', style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }
}

Color _setSemanticColour(value) {
  if (value < 0.25) {
    return Colors.red;
  } else if (value < 0.75) {
    return Colors.orange;
  } else {
    return Colors.green;
  }
}
