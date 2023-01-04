import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/home/screen_home.dart';
import 'package:poimen/screens/profile_choose/screen_profile_choose.dart';
import 'package:poimen/screens/search/search_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileChooseScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Hero(
        tag: 'bottomNavBar',
        child: BottomNavigationBar(
          onTap: (index) => setState(() => currentIndex = index),
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.magnifyingGlass),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidCircleUser),
              label: 'Profiles',
            ),
          ],
        ),
      ),
    );
  }
}
