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
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class BacentaAttendanceTickerScreen extends StatelessWidget {
  const BacentaAttendanceTickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getBacentaMembers,
        variables: {
          'id': churchState.bacentaId,
          'serviceRecordId': churchState.serviceRecordId,
        },
        defaultPageTitle: 'Tick Bacenta Membership Attendance',
        bodyFunction: (data, [fetchMore]) {
          Widget body;

          final bacenta = ChurchForMemberListByCategory.fromJson(data?['bacentas'][0]);
          final service = ServiceWithPicture.fromJson(data?['serviceRecords'][0]);

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

                if (resultData.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          constraints: const BoxConstraints(maxHeight: 350, maxWidth: 350),
                          child: AlertBox(
                              type: AlertType.success,
                              message: 'Attendance Report has been submitted successfully!',
                              buttonText: 'View Report',
                              onRetry: () {
                                Navigator.of(context).popUntil((route) => route.isFirst);
                                Navigator.of(context)
                                    .pushReplacementNamed('/servicerecord/attendance-report');
                              }),
                        ),
                      );
                    },
                  );
                }
              },
              onError: (error) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      constraints: const BoxConstraints(maxHeight: 350, maxWidth: 350),
                      child: AlertBox(
                        type: AlertType.error,
                        title: 'Error Submitting Attendance Report',
                        message: getGQLException(error),
                        buttonText: 'OK',
                        onRetry: () => Navigator.of(context).pop(),
                      ),
                    ),
                  );
                },
              ),
            ),
          );

          body = AttendanceTickerScreen(
            category: ServiceCategory.service,
            church: bacenta,
            service: service,
            tickerMutation: attendanceMutation,
          );

          var returnValues = GQLQueryContainerReturnValue(
            pageTitle: PageTitle(
              pageTitle: 'Attendance',
              church: bacenta,
              showBackButton: true,
              onBackPressed: () => Navigator.of(context).pop(),
            ),
            body: body,
          );

          return returnValues;
        });
  }
}
