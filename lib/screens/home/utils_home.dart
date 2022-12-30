import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/home/utils_cycle_countdown.dart';
import 'package:poimen/screens/home/widget_cycle_countdown.dart';
import 'package:poimen/screens/home/widget_home_page_button.dart';
import 'package:poimen/state/enums.dart';

String parseRole(Role role) {
  switch (role) {
    case Role.leaderFellowship:
      return 'Fellowship Leader';
    case Role.leaderBacenta:
      return 'Bacenta Leader';
    case Role.leaderConstituency:
      return 'Constituency Leader';
    case Role.leaderCouncil:
      return 'Council Leader';
    case Role.leaderStream:
      return 'Stream Leader';
    case Role.leaderGathering:
      return 'Gathering Service Leader';
    default:
      return '';
  }
}

List<Widget> countdownLevels(HomeScreenChurch church) {
  String level = church.typename.toLowerCase();
  final churchLevel = convertToChurchEnum(level);

  const permittedLevels = [
    ChurchLevel.fellowship,
    ChurchLevel.bacenta,
    ChurchLevel.constituency,
    ChurchLevel.council,
  ];

  if (!permittedLevels.contains(churchLevel)) {
    return [Container()];
  }
  final daysInCycle = church.currentPastoralCycle?.numberOfDays ?? 0;
  final daysLeftInCycle =
      getNumberOfDaysTillDeadline(DateTime.parse(church.currentPastoralCycle?.endDate ?? ''));

  return [
    const Padding(padding: EdgeInsets.all(10.0)),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CycleCountdownWidget(daysLeftInCycle: daysLeftInCycle, daysInCycle: daysInCycle),
      ],
    )
  ];
}

List<Widget> attendanceLevels(ChurchLevel churchLevel) {
  if (churchLevel != ChurchLevel.fellowship) {
    return [Container()];
  }

  ChurchString level = ChurchString(churchLevel.name);

  return [
    HomePageButton(
      text: 'Sunday Attendance',
      icon: FontAwesomeIcons.busSimple,
      navKey: 'attendance',
      route: '/bussingrecord-services',
      permitted: [Role.values.byName('leader${level.properCase}')],
    ),
    HomePageButton(
      text: 'Weekday Attendance',
      icon: FontAwesomeIcons.userCheck,
      navKey: 'attendance',
      route: '/servicerecord-services',
      permitted: [Role.values.byName('leader${level.properCase}')],
    ),
  ];
}

Widget imclLevels(ChurchLevel churchLevel, int? imclTotal) {
  const permittedLevels = [
    ChurchLevel.constituency,
    ChurchLevel.council,
    ChurchLevel.stream,
    ChurchLevel.gathering
  ];

  if (!permittedLevels.contains(churchLevel) || imclTotal == 0) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: 'IMCL Total',
    icon: FontAwesomeIcons.personCircleQuestion,
    navKey: 'imcl-total',
    route: '#',
    alertNumber: imclTotal,
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}

Widget defaultersLevels(ChurchLevel churchLevel) {
  const permittedLevels = [
    ChurchLevel.constituency,
    ChurchLevel.council,
    ChurchLevel.stream,
    ChurchLevel.gathering
  ];

  if (!permittedLevels.contains(churchLevel)) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: 'Attendance Defaulters',
    icon: FontAwesomeIcons.userXmark,
    navKey: 'attendance-defaulters',
    route: '/${level.lowerCase}/attendance-defaulters',
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}

// PASTORAL DUTIES

Widget outstandingVisitationLevels(ChurchLevel churchLevel, int? outstandingVisitationTotal) {
  const permittedLevels = [
    ChurchLevel.fellowship,
    ChurchLevel.bacenta,
    ChurchLevel.constituency,
    ChurchLevel.council,
  ];

  if (!permittedLevels.contains(churchLevel) || outstandingVisitationTotal == 0) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: 'Visitations',
    icon: FontAwesomeIcons.doorOpen,
    navKey: 'outstanding-visitation',
    route: '/${level.lowerCase}/outstanding-visitation',
    alertNumber: outstandingVisitationTotal,
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}

Widget outstandingPrayerLevels(ChurchLevel churchLevel, int? outstandingPrayerTotal) {
  const permittedLevels = [
    ChurchLevel.fellowship,
    ChurchLevel.bacenta,
    ChurchLevel.constituency,
    ChurchLevel.council,
  ];

  if (!permittedLevels.contains(churchLevel) || outstandingPrayerTotal == 0) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: 'Prayer',
    icon: FontAwesomeIcons.personPraying,
    navKey: 'outstanding-prayer',
    route: '/${level.lowerCase}/outstanding-prayer',
    alertNumber: outstandingPrayerTotal,
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}

Widget outstandingTelepastoringLevels(ChurchLevel churchLevel, int? outstandingTelepastoringTotal) {
  const permittedLevels = [
    ChurchLevel.fellowship,
    ChurchLevel.bacenta,
    ChurchLevel.constituency,
    ChurchLevel.council,
  ];

  if (!permittedLevels.contains(churchLevel) || outstandingTelepastoringTotal == 0) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: 'Telepastoring Calls',
    icon: FontAwesomeIcons.phone,
    navKey: 'outstanding-telepastoring',
    route: '/${level.lowerCase}/outstanding-telepastoring',
    alertNumber: outstandingTelepastoringTotal,
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}
