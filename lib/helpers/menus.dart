import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const _higherChurches = ['constituency', 'council', 'stream', 'gathering'];

List<Map<String, dynamic>?> getAttendanceMenus(String churchLevel) => [
      {'title': 'Home', 'icon': Icons.home, 'route': '/home', 'navKey': 'home'},
      churchLevel == 'fellowship' || churchLevel == 'bacenta'
          ? {
              'title': 'Attendance',
              'icon': FontAwesomeIcons.checkDouble,
              'route': '/$churchLevel-services',
              'navKey': 'attendance'
            }
          : null,
      churchLevel == 'fellowship'
          ? {
              'title': 'IDLs',
              'icon': FontAwesomeIcons.doorOpen,
              'route': '/$churchLevel-idls',
              'navKey': 'idls'
            }
          : null,
      _higherChurches.contains(churchLevel)
          ? {
              'title': 'Defaulters',
              'icon': FontAwesomeIcons.xmark,
              'route': '/$churchLevel/attendance-defaulters',
              'navKey': 'attendance-defaulters'
            }
          : null,
      {
        'title': 'Members',
        'icon': FontAwesomeIcons.userGroup,
        'route': '/$churchLevel-members',
        'navKey': 'membership'
      },
    ];
