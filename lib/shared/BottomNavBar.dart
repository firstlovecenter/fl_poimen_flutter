import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        switch (index) {
          case 0:
            // do nothing
            break;
          case 1:
            Navigator.pushNamed(context, '/profile-choose');
            break;
        }
      },
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
    );
  }
}
