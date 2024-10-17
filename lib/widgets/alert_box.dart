import 'package:flutter/material.dart';
import 'package:poimen/theme.dart';

enum AlertType {
  success,
  info,
  warning,
  error,
}

class AlertBox extends StatelessWidget {
  final String message;
  final AlertType type;
  final String title;
  final String buttonText;
  final void Function()? onRetry;

  const AlertBox({
    Key? key,
    required this.message,
    this.title = '',
    this.buttonText = '',
    this.type = AlertType.warning,
    this.onRetry,
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

    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              title,
              style: PoimenTheme.heading2,
            ),
            const Padding(padding: EdgeInsets.all(10)),
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
                  child: Text(message),
                ),
              ],
            ),
            onRetry != null ? const SizedBox(height: 8.0) : const SizedBox.shrink(),
            onRetry != null
                ? ElevatedButton(
                    onPressed: onRetry,
                    child: Text(buttonText != '' ? buttonText : 'Try Again'),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

String getGQLException(dynamic exception) {
  if (exception == null) {
    return 'An unknown error occurred';
  }
  print('exception $exception');

  if (exception.graphqlErrors.isEmpty) {
    if (exception.linkException?.parsedResponse == null) {
      if (exception.linkException?.originalException != null) {
        return exception.linkException.originalException.toString();
      }

      return exception.originalException.toString();
    }

    if (exception.linkException?.parsedResponse?.errors == null) {
      return exception.linkException?.parsedResponse?.response['errorMessage']?.toString() ??
          'An unknown error occurred';
    }

    return exception.linkException?.parsedResponse?.errors?[0]?.message?.toString() ??
        exception.linkException?.originalException?.toString() ??
        exception.toString();
  }

  return exception.graphqlErrors[0].message.toString();
}
