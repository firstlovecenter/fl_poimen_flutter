import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(40.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
          ),
          submitButton(),
        ],
      ),
    );
  }
}

Widget submitButton() {
  return ElevatedButton(
    onPressed: () {},
    child: Text('Login'),
  );
}
