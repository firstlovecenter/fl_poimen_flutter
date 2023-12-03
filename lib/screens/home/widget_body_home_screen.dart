import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/home/models_home_screen.dart';
import 'package:poimen/screens/home/utils_home.dart';
import 'package:poimen/screens/home/widget_home_page_button.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/user_header_widget.dart';
import 'package:provider/provider.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
    required this.church,
  }) : super(key: key);

  final HomeScreenChurch church;

  @override
  Widget build(BuildContext context) {
    final churchState = context.watch<SharedState>();
    String level = church.typename.toLowerCase();
    final churchLevel = convertToChurchEnum(level);
    final levelForUrl = churchLevel.name.toLowerCase();

    Future.delayed(Duration.zero, () {
      if (church.currentPastoralCycle != null) {
        churchState.pastoralCycle = church.currentPastoralCycle!;
      }
    });

    int? totalFellowshipAttendanceDefaulters;

    if (church.fellowshipBussingAttendanceDefaultersCount != null &&
        church.fellowshipBussingAttendanceDefaultersCount != null) {
      totalFellowshipAttendanceDefaulters = church.fellowshipBussingAttendanceDefaultersCount! +
          church.fellowshipServiceAttendanceDefaultersCount!;
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: 22,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return const UserHeaderWidget();
            case 1:
              return Column(
                children: countdownLevels(church),
              );
            case 2:
              return const Padding(padding: EdgeInsets.all(20.0));
            case 3:
              return Text(
                '${church.name} ${church.typename}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22),
              );
            case 4:
              return const Padding(padding: EdgeInsets.all(5.0));
            case 5:
              return const Text(
                'Reports',
                style: TextStyle(
                  fontSize: 18,
                  color: PoimenTheme.textSecondary,
                ),
              );
            case 6:
              return Column(
                children: attendanceLevels(churchLevel),
              );
            case 7:
              return HomePageButton(
                text: 'First Timers and New Converts',
                icon: FontAwesomeIcons.userPlus,
                navKey: 'idls',
                route: '/$levelForUrl-idls',
                permitted: const [Role.leaderFellowship],
              );
            case 8:
              return HomePageButton(
                text: 'Membership List',
                navKey: 'membership',
                icon: FontAwesomeIcons.solidAddressBook,
                route: '/$levelForUrl-members',
                permitted: const [Role.all],
              );
            case 9:
              return const Padding(padding: EdgeInsets.all(6.0));
            case 10:
              return const Text(
                'Outstanding Work',
                style: TextStyle(
                  fontSize: 18,
                  color: PoimenTheme.textSecondary,
                ),
              );
            case 11:
              return const Padding(padding: EdgeInsets.all(6.0));
            case 12:
              return defaultersLevels(churchLevel, totalFellowshipAttendanceDefaulters);
            case 13:
              return HomePageButton(
                text: 'Missing Persons Call List',
                icon: FontAwesomeIcons.personCircleQuestion,
                navKey: 'imcls',
                route: '/$levelForUrl-imcls',
                alertNumber: church.imclTotal,
                permitted: const [
                  Role.leaderFellowship,
                  Role.leaderBacenta,
                  Role.leaderConstituency,
                  Role.adminConstituency
                ],
              );
            case 14:
              return imclLevels(churchLevel, church.imclTotal);
            case 15:
              return outstandingTelepastoringLevels(
                  churchLevel, church.outstandingTelepastoringCount);
            case 16:
              return outstandingVisitationLevels(churchLevel, church.outstandingVisitationsCount);
            case 17:
              return outstandingPrayerLevels(churchLevel, church.outstandingPrayerCount);
            case 18:
              return const Padding(padding: EdgeInsets.all(8.0));
            case 19:
              return const Text(
                'Trends',
                style: TextStyle(
                  fontSize: 18,
                  color: PoimenTheme.textSecondary,
                ),
              );
            case 20:
              return HomePageButton(
                text: 'My Trends',
                icon: FontAwesomeIcons.chartSimple,
                route: '/$levelForUrl-trends-menu',
                navKey: 'trends',
                permitted: const [Role.all],
              );
            case 21:
              return myLeadersTrendsLevels(churchLevel);
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
