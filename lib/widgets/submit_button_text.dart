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

class SubmitButtonText extends StatelessWidget {
  const SubmitButtonText({
    Key? key,
    required this.text,
    required this.isSubmitting,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final bool isSubmitting;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: isSubmitting ? null : onPressed,
      child: isSubmitting ? const SubmittingButtonText() : Text(text),
    );
  }
}
