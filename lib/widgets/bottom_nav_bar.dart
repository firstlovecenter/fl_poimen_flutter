import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.menu}) : super(key: key);

  final List<Map<String, dynamic>?> Function(String) menu;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);
    var church = churchState.church;

    String churchLevel = church.typename.toLowerCase();

    var menuArray = widget.menu(churchLevel);

    // print(_selectedIndex);
    return Hero(
      tag: 'bottomNavBar',
      child: BottomNavigationBar(
        items: getIcons(menuArray, _selectedIndex),
        currentIndex: _selectedIndex,
        onTap: (int index) {
          _onItemTapped(index);

          List<String> routesArray = getRoutes(menuArray);

          switch (index) {
            case 0:
              Navigator.pushNamed(context, routesArray[0]);
              break;
            case 1:
              Navigator.pushNamed(context, routesArray[1]);
              break;
            case 2:
              Navigator.pushNamed(context, routesArray[2]);
              break;
          }
        },
      ),
    );
  }
}

getIcons(List<Map<String, dynamic>?> menuArray, dynamic i) {
  List<BottomNavigationBarItem> icons = [];

  for (var menu in menuArray) {
    if (menu != null) {
      icons.add(BottomNavigationBarItem(
        icon: Icon(menu['icon']),
        label: menu['title'],
      ));
    }
  }
  return icons;
}

getRoutes(List<Map<String, dynamic>?> menuArray) {
  List<String> routes = [];

  for (var menu in menuArray) {
    if (menu != null) {
      routes.add(menu['route']);
    }
  }
  return routes;
}
