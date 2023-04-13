import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/defaulters/service-attendance/widget_fellowship_defaulters_list.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class StreamServiceAttendanceDefaultersScreen extends StatelessWidget {
  const StreamServiceAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getStreamFellowshipAttendanceDefaultersList,
      variables: {'id': churchState.streamId},
      defaultPageTitle: 'Fellowship Attendance Defaulters',
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final stream = ChurchForServiceAttendanceDefaultersList.fromJson(data?['streams'][0]);

        body = FellowshipAttendanceDefaultersList(
          church: stream,
        );

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            pageTitle: 'Attendance Defaulters',
            church: stream,
          ),
          body: body,
        );
      },
    );
  }
}
