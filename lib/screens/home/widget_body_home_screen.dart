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
    var churchState = Provider.of<SharedState>(context);
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
      child: ListView(
        children: [
          const UserHeaderWidget(),
          ...countdownLevels(church),
          const Padding(padding: EdgeInsets.all(20.0)),
          Text(
            '${church.name} ${church.typename}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22),
          ),
          const Padding(padding: EdgeInsets.all(5.0)),
          ...attendanceLevels(churchLevel),
          HomePageButton(
            text: 'First Timers and New Converts',
            icon: FontAwesomeIcons.userPlus,
            navKey: 'idls',
            route: '/$levelForUrl-idls',
            permitted: const [Role.leaderFellowship],
          ),
          HomePageButton(
            text: 'Membership List',
            navKey: 'membership',
            icon: FontAwesomeIcons.solidAddressBook,
            route: '/$levelForUrl-members',
            permitted: const [Role.all],
          ),
          HomePageButton(
            text: 'My Trends',
            icon: FontAwesomeIcons.chartSimple,
            route: '/$levelForUrl-trends-menu',
            navKey: 'trends',
            permitted: const [Role.all],
          ),
          const Padding(padding: EdgeInsets.all(6.0)),
          const Center(
            child: Text(
              'Outstanding Work',
              style: TextStyle(
                fontSize: 18,
                color: PoimenTheme.textSecondary,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(6.0)),
          outstandingTelepastoringLevels(churchLevel, church.outstandingTelepastoringCount),
          defaultersLevels(churchLevel, totalFellowshipAttendanceDefaulters),
          HomePageButton(
            text: 'Missing Persons Call List',
            icon: FontAwesomeIcons.personCircleQuestion,
            navKey: 'imcls',
            route: '/$levelForUrl-imcls',
            alertNumber: church.imclTotal,
            permitted: const [Role.leaderFellowship, Role.leaderBacenta],
          ),
          imclLevels(churchLevel, church.imclTotal),
          outstandingVisitationLevels(churchLevel, church.outstandingVisitationsCount),
          outstandingPrayerLevels(churchLevel, church.outstandingPrayerCount),
        ],
      ),
    );
  }
}
