import 'package:flutter/material.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key, required this.menu, this.index}) : super(key: key);

  int? index = 0;
  final List<Map<String, dynamic>?> Function(ChurchLevel) menu;

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);
    var church = churchState.church;

    final churchLevel = convertToChurchEnum(church.typename.toLowerCase());

    var menuArray = menu(churchLevel);
    int computedIndex = 0;
    menuArray.removeWhere((element) => element == null);

    if (index! > menuArray.length - 1) {
      computedIndex = menuArray.length - 1;
    } else {
      computedIndex = index!;
    }

    return Hero(
      tag: 'bottomNavBar',
      child: BottomNavigationBar(
        items: getIcons(menuArray),
        currentIndex: computedIndex,
        onTap: (int index) {
          churchState.bottomNavSelected = menuArray[index]?['navKey'];

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
            case 3:
              Navigator.pushNamed(context, routesArray[3]);
              break;
            case 4:
              Navigator.pushNamed(context, routesArray[4]);
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
