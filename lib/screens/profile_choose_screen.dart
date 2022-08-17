import 'package:flutter/material.dart';

class ProfileChooseScreen extends StatelessWidget {
  const ProfileChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Which profile would you like to access?'),
          ],
        ),
      ),
    );
  }
}
