import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/widget_bussing_defaulters_list.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GovernorshipBussingAttendanceDefaultersScreen extends StatelessWidget {
  const GovernorshipBussingAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getGovernorshipBussingAttendanceDefaultersList,
      variables: {'id': churchState.governorshipId},
      defaultPageTitle: 'Bussing Attendance Defaulters',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final governorship =
            ChurchForBussingAttendanceDefaultersList.fromJson(data?['governorships'][0]);

        body = BussingAttendanceDefaultersList(
          church: governorship,
        );

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
