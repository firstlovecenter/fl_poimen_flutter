import 'package:flutter/material.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key, required this.menu, this.index}) : super(key: key);

  final int? index;
  final List<Map<String, dynamic>?> Function(ChurchLevel) menu;

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);
    var church = churchState.church;

    final churchLevel = convertToChurchEnum(church.typename.toLowerCase());

    var menuArray = menu(churchLevel);
    int computedIndex = 0;
    menuArray.removeWhere((element) => element == null);

    if ((index ?? 0) > menuArray.length - 1) {
      computedIndex = menuArray.length - 1;
    } else {
      computedIndex = index ?? 0;
    }

    return Hero(
      tag: 'bottomNavBar',
      child: BottomNavigationBar(
        items: getIcons(menuArray),
        currentIndex: computedIndex,
        onTap: (int index) {
          churchState.bottomNavSelected = menuArray[index]?['navKey'];

          List<String> routesArray = getRoutes(menuArray);
          if (index == computedIndex) {
            return;
          }

          switch (index) {
            case 0:
              Navigator.of(context).pushNamedAndRemoveUntil(routesArray[0], (route) => false);
              break;
            case 1:
              Navigator.of(context).pushNamedAndRemoveUntil(routesArray[1], (route) => false);
              break;
            case 2:
              Navigator.of(context).pushNamedAndRemoveUntil(routesArray[2], (route) => false);
              break;
            case 3:
              Navigator.of(context).pushNamedAndRemoveUntil(routesArray[3], (route) => false);
              break;
            case 4:
              Navigator.of(context).pushNamedAndRemoveUntil(routesArray[4], (route) => false);
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
