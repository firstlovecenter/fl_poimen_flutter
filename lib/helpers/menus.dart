import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>?> getAttendanceMenus(String churchLevel) => [
      {
        'title': 'Home',
        'icon': Icons.home,
        'route': '/home',
      },
      churchLevel == 'fellowship'
          ? {
              'title': 'IDLs',
              'icon': FontAwesomeIcons.doorOpen,
              'route': '/$churchLevel-idls',
            }
          : null,
      {
        'title': 'Members',
        'icon': FontAwesomeIcons.userGroup,
        'route': '/$churchLevel-members',
      },
    ];
