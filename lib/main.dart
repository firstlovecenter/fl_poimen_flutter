import 'package:flutter/material.dart';
import 'package:poimen/routes.dart';
import 'package:poimen/screens/login_screen.dart';
import 'package:poimen/theme.dart';

void main() {
  runApp(const PoimenApp());
}

class PoimenApp extends StatelessWidget {
  const PoimenApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      darkTheme: lightTheme,
      routes: appRoutes,
      home: const LoginScreen(),
    );
  }
}
