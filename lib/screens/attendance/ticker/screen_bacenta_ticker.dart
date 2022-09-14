import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/attendance/ticker/attendance_form.dart';
import 'package:poimen/screens/attendance/ticker/gql_ticker.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_query_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class BacentaAttendanceTickerScreen extends StatelessWidget {
  const BacentaAttendanceTickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
        query: getBacentaMembers,
        variables: {
          'id': churchState.bacentaId,
          'bussingRecordId': churchState.bussingRecordId,
        },
        defaultPageTitle: 'Tick Bacenta Membership Attendance',
        bodyFunction: (data) {
          Widget body;

          final bacenta = ChurchForMemberList.fromJson(data?['bacentas'][0]);
          final attendanceMutation = useMutation(
            MutationOptions(
              document: recordMemberBacentaAttendance,
              // ignore: void_checks
              update: (cache, result) {
                return cache;
              },
              onCompleted: (resultData) {
                Navigator.pushNamed(context, '/bacenta/attendance-report');
              },
            ),
          );

          body = AttendanceTickerScreen(
            church: bacenta,
            tickerMutation: attendanceMutation,
          );

          var returnValues = GQLQueryContainerReturnValue(
              pageTitle: PageTitle(
                pageTitle: 'Tick Membership Attendance',
                church: bacenta,
              ),
              body: body);

          return returnValues;
        });
  }
}
