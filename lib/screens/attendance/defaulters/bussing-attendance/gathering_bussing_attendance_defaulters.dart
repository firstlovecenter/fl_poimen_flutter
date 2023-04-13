import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/widget_bussing_defaulters_list.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GatheringBussingAttendanceDefaultersScreen extends StatelessWidget {
  const GatheringBussingAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getGatheringBussingAttendanceDefaultersList,
      variables: {'id': churchState.gatheringId},
      defaultPageTitle: 'Bacenta Attendance Defaulters',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final gathering =
            ChurchForBussingAttendanceDefaultersList.fromJson(data?['gatheringServices'][0]);

        body = BussingAttendanceDefaultersList(
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
