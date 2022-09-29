import 'package:flutter/material.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key, required this.menu}) : super(key: key);

  final List<Map<String, dynamic>?> Function(String) menu;

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);
    var church = churchState.church;

    String churchLevel = church.typename.toLowerCase();

    var menuArray = menu(churchLevel);

    return Hero(
      tag: 'bottomNavBar',
      child: BottomNavigationBar(
        items: getIcons(menuArray),
        currentIndex: churchState.bottomNavSelectedIndex,
        onTap: (int index) {
          churchState.bottomNavSelectedIndex = index;

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

getIcons(List<Map<String, dynamic>?> menuArray) {
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
