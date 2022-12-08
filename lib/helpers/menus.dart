import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/state/enums.dart';

const _higherChurches = [
  ChurchLevel.constituency,
  ChurchLevel.council,
  ChurchLevel.stream,
  ChurchLevel.gathering
];

List<Map<String, dynamic>?> getAttendanceMenus(ChurchLevel churchLevel) {
  final levelForUrl = churchLevel.name.toLowerCase();

  return [
    {'title': 'Home', 'icon': Icons.home, 'route': '/home', 'navKey': 'home'},
    churchLevel == ChurchLevel.fellowship
        ? {
            'title': 'Attendance',
            'icon': FontAwesomeIcons.userCheck,
            'route': '/servicerecord-services',
            'navKey': 'attendance'
          }
        : null,
    churchLevel == ChurchLevel.fellowship || churchLevel == ChurchLevel.bacenta
        ? {
            'title': 'IMCLs',
            'icon': FontAwesomeIcons.personCircleQuestion,
            'route': '/$levelForUrl-imcls',
            'navKey': 'imcls'
          }
        : null,
    churchLevel == ChurchLevel.fellowship
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
    churchLevel == ChurchLevel.fellowship || churchLevel == ChurchLevel.bacenta
        ? {
            'title': 'IMCLs',
            'icon': FontAwesomeIcons.personCircleQuestion,
            'route': '/$levelForUrl-imcls',
            'navKey': 'imcls'
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
