import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/attendance/ticker/widget_attendance_form.dart';
import 'package:poimen/screens/attendance/ticker/gql_ticker.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class FellowshipAttendanceTickerScreen extends StatelessWidget {
  const FellowshipAttendanceTickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
        query: getFellowshipMembers,
        variables: {
          'id': churchState.fellowshipId,
          'serviceRecordId': churchState.serviceRecordId,
        },
        defaultPageTitle: 'Tick Fellowship Membership Attendance',
        bodyFunction: (data) {
          Widget body;

          final fellowship = ChurchForMemberList.fromJson(data?['fellowships'][0]);

          final attendanceMutation = useMutation(
            MutationOptions(
              document: recordMembershipAttendance,
              // ignore: void_checks
              update: (cache, result) {
                return cache;
              },
              onCompleted: (resultData) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/fellowship/attendance-report', (route) => false);
              },
            ),
          );

          body = AttendanceTickerScreen(
            church: fellowship,
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
