import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const AuthButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
      ),
      child: Text(text),
      onPressed: () => onPressed(),
    );
  }
}
