import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/trends/membership/widget_membership_trends.dart';
import 'package:poimen/screens/trends/models_trends.dart';
import 'package:poimen/screens/trends/membership/gql_membership_trends.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class CouncilMembershipAttendanceScreen extends StatelessWidget {
  const CouncilMembershipAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getCouncilMembershipAttendanceTrends,
        variables: {'id': churchState.councilId},
        bottomNavBar: const BottomNavBar(menu: getMyTrendsMenus, index: 2),
        defaultPageTitle: 'Membership Attendance Trends',
        bodyFunction: (data) {
          Widget body;

          final council = ChurchForMembershipAttendanceTrends.fromJson(data?['councils'][0]);

          body = MembershipTrendsWidget(
            church: council,
          );

          var returnValues = GQLQueryContainerReturnValue(
            pageTitle: PageTitle(church: council, pageTitle: 'Membership Attendance Trends'),
            body: body,
          );

          return returnValues;
        });
  }
}
