import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/state/enums.dart';

const _higherChurches = [
  ChurchLevel.governorship,
  ChurchLevel.council,
  ChurchLevel.stream,
  ChurchLevel.campus
];

List<Map<String, dynamic>?> getAttendanceMenus(ChurchLevel churchLevel) {
  final levelForUrl = churchLevel.name.toLowerCase();

  return [
    {'title': 'Home', 'icon': Icons.home, 'route': '/home', 'navKey': 'home'},
    churchLevel == ChurchLevel.governorship
        ? {
            'title': 'Record Attendance',
            'icon': FontAwesomeIcons.userCheck,
            'route': '/record-attendance',
            'navKey': 'attendance'
          }
        : null,
    churchLevel == ChurchLevel.bacenta
        ? {
            'title': 'IDLs',
            'icon': FontAwesomeIcons.userPlus,
            'route': '/$levelForUrl-idls',
            'navKey': 'idls'
          }
        : null,
    _higherChurches.contains(churchLevel)
        ? {
            'title': 'Defaulters',
            'icon': FontAwesomeIcons.userXmark,
            'route': '/$levelForUrl/attendance-defaulters',
            'navKey': 'attendance-defaulters'
          }
        : null,
    {
      'title': 'Members',
      'icon': FontAwesomeIcons.solidAddressBook,
      'route': '/$levelForUrl-members',
      'navKey': 'membership'
    },
  ];
}

List<Map<String, dynamic>?> getDutiesMenus(ChurchLevel churchLevel) {
  final levelForUrl = churchLevel.name.toLowerCase();

  return [
    {'title': 'Home', 'icon': Icons.home, 'route': '/home', 'navKey': 'home'},
    [
      ChurchLevel.bacenta,
      ChurchLevel.governorship,
    ].contains(churchLevel)
        ? {
            'title': 'IMCLs',
            'icon': FontAwesomeIcons.personCircleQuestion,
            'route': '/$levelForUrl-imcls',
            'navKey': 'imcls'
          }
        : null,
    [
      ChurchLevel.bacenta,
      ChurchLevel.governorship,
      ChurchLevel.council,
    ].contains(churchLevel)
        ? {
            'title': 'Visit',
            'icon': FontAwesomeIcons.doorOpen,
            'route': '/$levelForUrl/outstanding-visitation',
            'navKey': 'outstanding-visitation'
          }
        : null,
    [
      ChurchLevel.bacenta,
      ChurchLevel.governorship,
      ChurchLevel.council,
    ].contains(churchLevel)
        ? {
            'title': 'Prayer',
            'icon': FontAwesomeIcons.personPraying,
            'route': '/$levelForUrl/outstanding-prayer',
            'navKey': 'outstanding-prayer'
          }
        : null,
    [
      ChurchLevel.bacenta,
      ChurchLevel.governorship,
      ChurchLevel.council,
    ].contains(churchLevel)
        ? {
            'title': 'Telepastoring',
            'icon': FontAwesomeIcons.phone,
            'route': '/$levelForUrl/outstanding-telepastoring',
            'navKey': 'outstanding-telepastoring'
          }
        : null,
  ];
}

List<Map<String, dynamic>?> getTrendsMenus(ChurchLevel churchLevel) {
  final levelForUrl = churchLevel.name.toLowerCase();

  return [
    {'title': 'Home', 'icon': Icons.home, 'route': '/home', 'navKey': 'home'},
    {
      'title': 'My Trends',
      'icon': FontAwesomeIcons.chartSimple,
      'route': '/$levelForUrl-trends-menu',
      'navKey': 'pastoral-work'
    },
    {
      'title': 'My Leaders Trends',
      'icon': FontAwesomeIcons.chartPie,
      'route': '/$levelForUrl-subleaders-trends',
      'navKey': 'membership-attendance'
    },
  ];
}

List<Map<String, dynamic>?> getMyTrendsMenus(ChurchLevel churchLevel) {
  final levelForUrl = churchLevel.name.toLowerCase();

  return [
    {'title': 'Home', 'icon': Icons.home, 'route': '/home', 'navKey': 'home'},
    {
      'title': 'Pastoral Work',
      'icon': FontAwesomeIcons.solidClock,
      'route': '/trends/$levelForUrl/pastoral-work-cycles',
      'navKey': 'pastoral-work-cycles'
    },
    {
      'title': 'Membership',
      'icon': FontAwesomeIcons.solidChartBar,
      'route': '/trends/$levelForUrl/membership-attendance',
      'navKey': 'membership-attendance'
    },
  ];
}
