import 'package:flutter/material.dart';
import 'package:poimen/routes.dart';
import 'package:poimen/screens/login_screen.dart';

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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, withoRut quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: appRoutes,
      home: const LoginScreen(),
    );
  }
}
