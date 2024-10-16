import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/gql_subchurch_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/widget_church_by_subchurch_attendance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class CouncilByGovernorshipAttendanceDefaultersScreen extends StatelessWidget {
  const CouncilByGovernorshipAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getCouncilAttendanceDefaultersByGovernorship,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Attendance Defaulters',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 1),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final council = ChurchBySubChurchForAttendanceDefaulters.fromJson(data?['councils'][0]);

        body = ChurchBySubChurchAttendanceDefaulters(church: council);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            pageTitle: 'Attendance Defaulters',
            church: council,
          ),
          body: body,
        );
      },
    );
  }
}
