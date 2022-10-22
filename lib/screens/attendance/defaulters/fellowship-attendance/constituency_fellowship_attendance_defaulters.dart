import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/defaulters/fellowship-attendance/widget_fellowship_defaulters_list.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class ConstituencyFellowshipAttendanceDefaultersScreen extends StatelessWidget {
  const ConstituencyFellowshipAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getConstituencyFellowshipAttendanceDefaultersList,
      variables: {'id': churchState.constituencyId},
      defaultPageTitle: 'Fellowship Attendance Defaulters',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final constituency =
            ChurchForFellowshipAttendanceDefaultersList.fromJson(data?['constituencies'][0]);

        body = FellowshipAttendanceDefaultersList(
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
