import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key, required this.menu, this.index}) : super(key: key);

  final int? index;
  final List<Map<String, dynamic>?> Function(ChurchLevel) menu;

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();
    var church = churchState.church;
    final mediaQuery = MediaQuery.of(context);
    final brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final screenWidth = mediaQuery.size.width;
    final isTablet = screenWidth >= 600 && screenWidth < 900;
    final isDesktop = screenWidth >= 900;

    final churchLevel = convertToChurchEnum(church.typename.toLowerCase());

    var menuArray = menu(churchLevel);
    menuArray.removeWhere((element) => element == null);

    int computedIndex = 0;
    if ((index ?? 0) > menuArray.length - 1) {
      computedIndex = menuArray.length - 1;
    } else {
      computedIndex = index ?? 0;
    }

    // Define the visual properties for the bottom navigation bar
    final navBarShape = RoundedRectangleBorder(
      borderRadius: isTablet || isDesktop
          ? const BorderRadius.vertical(top: Radius.circular(16))
          : const BorderRadius.vertical(top: Radius.circular(12)),
    );

    final navBarElevation = isDarkMode ? 12.0 : 8.0;

    final navBarBackgroundColor = isDarkMode ? Colors.grey.shade900 : Colors.white;

    // Define sizes based on device
    final iconSize = isDesktop
        ? 24.0
        : isTablet
            ? 22.0
            : 20.0;
    final labelFontSize = isDesktop
        ? 14.0
        : isTablet
            ? 12.0
            : 10.0;
    final navBarHeight = isDesktop
        ? 70.0
        : isTablet
            ? 60.0
            : 56.0;

    return Hero(
      tag: 'bottomNavBar',
      child: Material(
        elevation: navBarElevation,
        shadowColor: isDarkMode ? Colors.black.withOpacity(0.5) : Colors.grey.withOpacity(0.3),
        shape: navBarShape,
        child: SizedBox(
          height: navBarHeight,
          child: BottomNavigationBar(
            useLegacyColorScheme: false,
            backgroundColor: navBarBackgroundColor,
            selectedItemColor: PoimenTheme.brand,
            unselectedItemColor: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: labelFontSize,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: labelFontSize,
            ),
            elevation: 0, // Elevation is handled by the parent Material widget
            type: BottomNavigationBarType.fixed,
            iconSize: iconSize,
            selectedFontSize: labelFontSize,
            unselectedFontSize: labelFontSize,
            items: getIcons(menuArray),
            currentIndex: computedIndex,
            onTap: (int index) {
              // Add haptic feedback for better user experience
              HapticFeedback.mediumImpact();

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
        ),
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
