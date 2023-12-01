import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/widget_bussing_defaulters_list.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class ConstituencyBussingAttendanceDefaultersScreen extends StatelessWidget {
  const ConstituencyBussingAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getConstituencyBussingAttendanceDefaultersList,
      variables: {'id': churchState.constituencyId},
      defaultPageTitle: 'Bussing Attendance Defaulters',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final constituency =
            ChurchForBussingAttendanceDefaultersList.fromJson(data?['constituencies'][0]);

        body = BussingAttendanceDefaultersList(
          church: constituency,
        );

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            pageTitle: 'Attendance Defaulters',
            church: constituency,
          ),
          body: body,
        );
      },
    );
  }
}
