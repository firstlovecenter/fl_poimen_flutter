import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/report/gql_report.dart';
import 'package:poimen/screens/attendance/report/models_service_reports.dart';
import 'package:poimen/screens/attendance/report/widget_service_report.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class ConstituencyAttendanceReportScreen extends StatelessWidget {
  const ConstituencyAttendanceReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getConstituencyServiceReport,
        variables: {
          'constituencyId': churchState.constituencyId,
          'serviceRecordId': churchState.serviceRecordId,
        },
        defaultPageTitle: 'Constituency Attendance Report',
        bodyFunction: (data, [fetchMore]) {
          Widget body;

          final constituency = Church.fromJson(data?['constituencys'][0]);

          if (data?['serviceRecords'].isEmpty) {
            body = const Center(child: Text('No Service Records'));

            return GQLQueryContainerReturnValue(
              pageTitle: PageTitle(pageTitle: 'Attendance Report', church: constituency),
              body: body,
            );
          }

          final serviceRecord = ServicesForReport.fromJson(data?['serviceRecords'][0]);

          body = ChurchServicesReport(
            church: constituency,
            record: serviceRecord,
          );

          return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(pageTitle: 'Attendance Report', church: constituency),
            body: body,
          );
        });
  }
}
