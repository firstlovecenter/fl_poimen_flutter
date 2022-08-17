import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const Text('dsata'),
    const ProfileChooseScreen()
    // const LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => currentIndex = index),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              label: 'Profiles',
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }
}
