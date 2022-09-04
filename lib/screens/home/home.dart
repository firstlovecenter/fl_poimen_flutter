import 'package:flutter/material.dart';
import 'package:poimen/screens/home/home_screen.dart';
import 'package:poimen/screens/profile_choose/screen_profile_choose.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final List<Widget> screens = [const HomeScreen(), const ProfileChooseScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => currentIndex = index),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.red),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Profiles',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
