import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: -math.pi / 9,
              child: Image.asset('assets/images/flc_logo_silver.png'),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 40.0,
              ),
            ),
            const Text('FLC Pastoral Care'),
          ],
        ),
      ),
    );
  }
}
