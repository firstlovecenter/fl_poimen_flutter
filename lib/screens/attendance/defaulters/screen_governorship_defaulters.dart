import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/widget_attedance_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GovernorshipAttendanceDefaultersScreen extends StatelessWidget {
  const GovernorshipAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getGovernorshipAttendanceDefaulters,
      variables: {'id': churchState.governorshipId},
      defaultPageTitle: 'Governorship Attendance Defaulters',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 1),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final governorship = ChurchForAttendanceDefaulters.fromJson(data?['governorships'][0]);

        body = ChurchAttendanceDefaulters(church: governorship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            pageTitle: 'Attendance Defaulters',
            church: governorship,
          ),
          body: body,
        );
      },
    );
  }
}
