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
    case Role.leaderGovernorship:
      return 'Governorship Leader';
    case Role.adminGovernorship:
      return 'Governorship Admin';
    case Role.leaderCouncil:
      return 'Council Leader';
    case Role.adminCouncil:
      return 'Council Admin';
    case Role.leaderStream:
      return 'Stream Leader';
    case Role.adminStream:
      return 'Stream Admin';
    case Role.leaderCampus:
      return 'Campus Leader';
    case Role.adminCampus:
      return 'Campus Admin';

    //* Creative Arts Roles
    case Role.leaderHub:
      return 'Hub Leader';
    case Role.leaderHubCouncil:
      return 'Hub Council Leader';
    case Role.leaderMinistry:
      return 'Ministry Leader';
    case Role.adminMinistry:
      return 'Ministry Admin';
    case Role.leaderCreativeArts:
      return 'Creative Arts Leader';
    case Role.adminCreativeArts:
      return 'Creative Arts Admin';
    default:
      return '';
  }
}

List<Widget> countdownLevels(HomeScreenChurch church) {
  String level = church.typename.toLowerCase();
  final churchLevel = convertToChurchEnum(level);

  const permittedLevels = [
    ChurchLevel.bacenta,
    ChurchLevel.governorship,
    ChurchLevel.council,
    ChurchLevel.hub,
    ChurchLevel.hubCouncil,
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
  ChurchString level = ChurchString(churchLevel.name);
  if (churchLevel == ChurchLevel.governorship) {
    return [
      HomePageButton(
        text: 'Record Attendance',
        icon: FontAwesomeIcons.userCheck,
        navKey: 'attendance',
        route: '/record-attendance',
        permitted: [Role.values.byName('leader${level.properCase}')],
      ),
    ];
  }

  return [Container()];
}

List<Widget> hubAttendanceLevels(ChurchLevel churchLevel) {
  if (churchLevel != ChurchLevel.hub) {
    return [Container()];
  }

  ChurchString level = ChurchString(churchLevel.name);

  return [
    HomePageButton(
      text: 'Rehearsal Attendance',
      icon: FontAwesomeIcons.music,
      navKey: 'rehearsal-attendance',
      route: '/rehearsal-meetings',
      permitted: [Role.values.byName('leader${level.properCase}')],
    ),
  ];
}

Widget imclLevels(ChurchLevel churchLevel, int? imclTotal) {
  const permittedLevels = [
    ChurchLevel.governorship,
    ChurchLevel.council,
    ChurchLevel.stream,
    ChurchLevel.campus
  ];

  if (!permittedLevels.contains(churchLevel) || imclTotal == 0) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: 'IMCL Total',
    icon: FontAwesomeIcons.personCircleQuestion,
    navKey: 'imcl-total',
    route: '/${level.lowerCase}-imcls',
    alertNumber: imclTotal,
    permitted: [Role.values.byName('leader${level.properCase}')],
  );
}

Widget defaultersLevels(ChurchLevel churchLevel, int? defaulterCount) {
  const permittedLevels = [
    ChurchLevel.governorship,
    ChurchLevel.council,
    ChurchLevel.stream,
    ChurchLevel.campus
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
    alertNumber: defaulterCount,
    permitted: [
      Role.values.byName('leader${level.properCase}'),
      Role.values.byName('admin${level.properCase}')
    ],
  );
}

// PASTORAL DUTIES

Widget outstandingVisitationLevels(ChurchLevel churchLevel, int? outstandingVisitationTotal) {
  const permittedLevels = [
    ChurchLevel.fellowship,
    ChurchLevel.bacenta,
    ChurchLevel.governorship,
    ChurchLevel.council,
  ];

  if (!permittedLevels.contains(churchLevel)) {
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
    ChurchLevel.governorship,
    ChurchLevel.council,
  ];

  if (!permittedLevels.contains(churchLevel)) {
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
    ChurchLevel.governorship,
    ChurchLevel.council,
  ];

  if (!permittedLevels.contains(churchLevel)) {
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

Widget myLeadersTrendsLevels(ChurchLevel churchLevel) {
  const permittedLevels = [
    ChurchLevel.governorship,
    ChurchLevel.council,
    ChurchLevel.stream,
    ChurchLevel.campus,
  ];

  if (!permittedLevels.contains(churchLevel)) {
    return Container();
  }

  ChurchString level = ChurchString(churchLevel.name);

  return HomePageButton(
    text: 'My Leaders Trends',
    icon: FontAwesomeIcons.chartPie,
    route: '/${level.lowerCase}-subleaders-trends',
    navKey: 'subleaders-trends',
    permitted: const [Role.all],
  );
}
