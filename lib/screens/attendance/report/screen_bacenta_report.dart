import 'package:flutter/material.dart';
import 'package:poimen/screens/attendance/report/gql_report.dart';
import 'package:poimen/screens/attendance/report/models_service_reports.dart';
import 'package:poimen/screens/attendance/report/widget_service_report.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class BacentaAttendanceReportScreen extends StatelessWidget {
  const BacentaAttendanceReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getBacentaServiceReport,
        variables: {
          'bacentaId': churchState.bacentaId,
          'serviceRecordId': churchState.serviceRecordId,
        },
        defaultPageTitle: 'Bacenta Attendance Report',
        bodyFunction: (data, [fetchMore]) {
          Widget body;

          final bacenta = Church.fromJson(data?['bacentas'][0]);

          if (data?['serviceRecords'].isEmpty) {
            body = const Center(child: Text('No Service Records'));

            return GQLQueryContainerReturnValue(
              pageTitle: PageTitle(pageTitle: 'Attendance Report', church: bacenta),
              body: body,
            );
          }

          final serviceRecord = ServicesForReport.fromJson(data?['serviceRecords'][0]);

          body = ChurchServicesReport(
            church: bacenta,
            record: serviceRecord,
          );

          return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(pageTitle: 'Attendance Report', church: bacenta),
            body: body,
          );
        });
  }
}
