import 'package:flutter/material.dart';

enum AlertType {
  success,
  info,
  warning,
  error,
}

class AlertBox extends StatelessWidget {
  final String text;
  final AlertType type;
  final void Function() onRetry;

  const AlertBox({
    Key? key,
    required this.text,
    this.type = AlertType.warning,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (type) {
      case AlertType.success:
        {
          icon = Icons.check_circle;
          color = Colors.green;
        }
        break;
      case AlertType.info:
        {
          icon = Icons.info_outline;
          color = Colors.green;
        }
        break;
      case AlertType.warning:
        {
          icon = Icons.report_problem;
          color = Colors.amber;
        }
        break;
      case AlertType.error:
        {
          icon = Icons.error_outline;
          color = Colors.red;
        }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 32.0,
              ),
              const SizedBox(
                width: 16.0,
              ),
              Flexible(
                child: Text(text),
              ),
            ],
          ),
          onRetry != null
              ? const SizedBox(height: 8.0)
              : const SizedBox.shrink(),
          onRetry != null
              ? TextButton(
                  onPressed: onRetry,
                  child: const Text('Try Again'),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
