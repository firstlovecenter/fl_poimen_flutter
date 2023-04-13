import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/defaulters/bussing-attendance/widget_bussing_defaulters_list.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class CouncilBussingAttendanceDefaultersScreen extends StatelessWidget {
  const CouncilBussingAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getCouncilBussingAttendanceDefaultersList,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Bussing Attendance Defaulters',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final council = ChurchForBussingAttendanceDefaultersList.fromJson(data?['councils'][0]);

        body = BussingAttendanceDefaultersList(
          church: council,
        );

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
