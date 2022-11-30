import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/screens/attendance/ticker/enums_ticker.dart';
import 'package:poimen/screens/attendance/ticker/gql_ticker.dart';
import 'package:poimen/screens/attendance/ticker/widget_attendance_ticker.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class BussingRecordAttendanceTickerScreen extends StatelessWidget {
  const BussingRecordAttendanceTickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
        query: getFellowshipMembersForBussing,
        variables: {
          'id': churchState.fellowshipId,
          'bussingRecordId': churchState.bussingRecordId,
        },
        defaultPageTitle: 'Tick Fellowship Membership Attendance',
        bodyFunction: (data, [fetchMore]) {
          Widget body;

          final fellowship = ChurchForMemberListByCategory.fromJson(data?['fellowships'][0]);
          final service = ServiceWithPicture.fromJson(data?['bussingRecords'][0]);

          final attendanceMutation = useMutation(
            MutationOptions(
              document: recordMembershipAttendance,
              // ignore: void_checks
              update: (cache, result) {
                return cache;
              },
              onCompleted: (resultData) {
                if (resultData == null) {
                  return;
                }

                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/bussingrecord/attendance-report', (route) => false);
              },
            ),
          );

          body = AttendanceTickerScreen(
            category: ServiceCategory.bussing,
            church: fellowship,
            service: service,
            tickerMutation: attendanceMutation,
          );

          var returnValues = GQLQueryContainerReturnValue(
              pageTitle: PageTitle(
                pageTitle: 'Tick Membership Attendance',
                church: fellowship,
              ),
              body: body);

          return returnValues;
        });
  }
}
