import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/attendance/ticker/enums_ticker.dart';
import 'package:poimen/screens/attendance/ticker/gql_ticker.dart';
import 'package:poimen/screens/attendance/ticker/widget_attendance_ticker_on_date.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/loading_indicator.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GovernorshipAttendanceTickerScreen extends StatelessWidget {
  const GovernorshipAttendanceTickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GQLQueryContainer(
      query: getGovernorshipMembers,
      variables: {
        'id': churchState.governorshipId,
      },
      defaultPageTitle: 'Tick Governorship Membership Attendance',
      loadingWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingIndicator(
              size: 60,
              strokeWidth: 5,
              color: PoimenTheme.brand,
            ),
            const SizedBox(height: 16),
            Text(
              'Loading membership data...',
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
      bodyFunction: (data, [fetchMore]) {
        if (data == null || data['governorships'] == null || data['governorships'].isEmpty) {
          return GQLQueryContainerReturnValue(
            pageTitle: const PageTitle(pageTitle: 'No Governorship Data Found'),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.red.withOpacity(0.7),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Could not find governorship data.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        }

        Widget body;
        final governorship = ChurchForMemberListByCategory.fromJson(data['governorships'][0]);

        final attendanceMutation = useMutation(
          MutationOptions(
            document: recordMembershipAttendanceOnDate,
            // ignore: void_checks
            update: (cache, result) => cache,
            onCompleted: (resultData) {
              if (resultData == null) return;

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
                          message: 'Attendance report submitted successfully!',
                          buttonText: 'View Report',
                          onRetry: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                            Navigator.of(context)
                                .pushReplacementNamed('/meetings/attendance-report');
                          },
                        ),
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

        body = WidgetAttendanceTickerOnDate(
          category: ServiceCategory.service,
          church: governorship,
          tickerMutation: attendanceMutation,
        );

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            pageTitle: 'Attendance',
            church: governorship,
            showBackButton: true, // Explicitly set to show only one back button
            onBackPressed: () => Navigator.of(context).pop(), // Define proper navigation
          ),
          body: body,
        );
      },
    );
  }
}
