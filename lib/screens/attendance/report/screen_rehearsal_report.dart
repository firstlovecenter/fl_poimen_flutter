import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/report/gql_report.dart';
import 'package:poimen/screens/attendance/report/models_service_reports.dart';
import 'package:poimen/screens/attendance/report/widget_rehearsal_report.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class HubAttendanceReportScreen extends StatelessWidget {
  const HubAttendanceReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getHubRehearsalReport,
        variables: {
          'hubId': churchState.hubId,
          'rehearsalRecordId': churchState.serviceRecordId,
        },
        defaultPageTitle: 'Hub Attendance Report',
        bodyFunction: (data, [fetchMore]) {
          Widget body;

          final hub = Church.fromJson(data?['hubs'][0]);

          if (data?['rehearsalRecords'].isEmpty) {
            body = const Center(child: Text('No Rehearsal Records'));

            return GQLQueryContainerReturnValue(
              pageTitle: PageTitle(pageTitle: 'Attendance Report', church: hub),
              body: body,
            );
          }

          final rehearsalRecord = RehearsalsForReport.fromJson(data?['rehearsalRecords'][0]);

          body = ChurchRehearsalsReport(
            church: hub,
            record: rehearsalRecord,
          );

          return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(pageTitle: 'Attendance Report', church: hub),
            body: body,
          );
        });
  }
}
