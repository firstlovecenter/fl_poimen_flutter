import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/defaulters/fellowship-attendance/widget_fellowship_defaulters_list.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GatheringFellowshipAttendanceDefaultersScreen extends StatelessWidget {
  const GatheringFellowshipAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getGatheringFellowshipAttendanceDefaultersList,
      variables: {'id': churchState.gatheringId},
      defaultPageTitle: 'Fellowship Attendance Defaulters',
      bodyFunction: (data) {
        Widget body;

        final gathering =
            ChurchForFellowshipAttendanceDefaultersList.fromJson(data?['gatheringServices'][0]);

        body = FellowshipAttendanceDefaultersList(
          church: gathering,
        );

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            pageTitle: 'Attendance Defaulters',
            church: gathering,
          ),
          body: body,
        );
      },
    );
  }
}
