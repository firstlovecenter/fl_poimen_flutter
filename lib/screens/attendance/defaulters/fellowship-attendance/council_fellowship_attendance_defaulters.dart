import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/defaulters/fellowship-attendance/widget_fellowship_defaulters_list.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class CouncilFellowshipAttendanceDefaultersScreen extends StatelessWidget {
  const CouncilFellowshipAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getCouncilFellowshipAttendanceDefaultersList,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Fellowship Attendance Defaulters',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final council = ChurchForFellowshipAttendanceDefaultersList.fromJson(data?['councils'][0]);

        body = FellowshipAttendanceDefaultersList(
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
