import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/attendance/gql_services_list.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/screens/attendance/widget_services_list.dart';
import 'package:poimen/screens/attendance/widget_services_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class RecordAttendanceScreen extends StatelessWidget {
  const RecordAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getGovernorshipMeetings,
        variables: {'id': churchState.governorshipId},
        defaultPageTitle: 'Services',
        bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 2),
        bodyFunction: (data, [fetchMore]) {
          Widget body;

          final governorship = ChurchForMeetingsList.fromJson(data?['governorships'][0]);

          body = RecordedMeetingsList(meetings: governorship.poimenMeetings);

          return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(
              pageTitle: 'Recent Meetings',
              church: governorship,
              showBackButton: true,
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            body: body,
          );
        });
  }
}
