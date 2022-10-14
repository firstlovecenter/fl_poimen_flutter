import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      child: SizedBox(
        height: 160,
        child: RiveAnimation.asset('assets/animations/loader.riv'),
      ),
    );
  }
}
