import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/defaulters/service-attendance/widget_fellowship_defaulters_list.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GovernorshipServiceAttendanceDefaultersScreen extends StatelessWidget {
  const GovernorshipServiceAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getGovernorshipFellowshipServiceAttendanceDefaultersList,
      variables: {'id': churchState.governorshipId},
      defaultPageTitle: 'Fellowship Attendance Defaulters',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final governorship =
            ChurchForServiceAttendanceDefaultersList.fromJson(data?['governorships'][0]);

        body = FellowshipAttendanceDefaultersList(
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
