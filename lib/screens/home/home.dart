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
    // Add error handling to prevent out of range errors
    Widget body;
    try {
      if (currentIndex >= 0 && currentIndex < screens.length) {
        body = screens[currentIndex];
      } else {
        // Fallback if index is somehow out of range
        body = const Center(child: Text('Screen index out of range'));
        // Reset to a valid index
        currentIndex = 0;
      }
    } catch (e) {
      // Catch any errors that might occur when trying to display a screen
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error loading screen'),
            Text('Error: $e'),
            ElevatedButton(
              onPressed: () => setState(() => currentIndex = 0),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: body,
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
