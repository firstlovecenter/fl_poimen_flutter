import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/report/gql_report.dart';
import 'package:poimen/screens/attendance/report/models_service_reports.dart';
import 'package:poimen/screens/attendance/report/widget_service_report.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class BussingAttendanceReportScreen extends StatelessWidget {
  const BussingAttendanceReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getBacentaBussingReport,
        variables: {
          'bacentaId': churchState.bacentaId,
          'bussingRecordId': churchState.bussingRecordId,
        },
        defaultPageTitle: 'Bacenta Attendance Report',
        bodyFunction: (data, [fetchMore]) {
          Widget body;

          final bacenta = Church.fromJson(data?['bacentas'][0]);
          final bussingRecord = ServicesForReport.fromJson(data?['bussingRecords'][0]);

          body = ChurchServicesReport(
            church: bacenta,
            record: bussingRecord,
          );

          return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(pageTitle: 'Attendance Report', church: bacenta),
            body: body,
          );
        });
  }
}
