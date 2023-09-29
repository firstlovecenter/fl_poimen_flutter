import 'package:flutter/material.dart';

class SubmittingButtonText extends StatelessWidget {
  const SubmittingButtonText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Submitting'),
        Padding(padding: EdgeInsets.all(5)),
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ],
    );
  }
}
