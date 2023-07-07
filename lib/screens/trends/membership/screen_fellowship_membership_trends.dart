import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/trends/gql_trends.dart';
import 'package:poimen/screens/trends/membership/widget_membership_trends.dart';
import 'package:poimen/screens/trends/models_trends.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class FellowshipMembershipAttendanceScreen extends StatelessWidget {
  const FellowshipMembershipAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
        query: getFellowshipMembershipAttendanceTrends,
        variables: {'id': churchState.fellowshipId},
        bottomNavBar: const BottomNavBar(menu: getMyTrendsMenus, index: 2),
        defaultPageTitle: 'Membership Attendance Trends',
        bodyFunction: (data) {
          Widget body;

          final fellowship = ChurchForMembershipAttendanceTrends.fromJson(data?['fellowships'][0]);

          body = MembershipTrendsWidget(
            church: fellowship,
          );

          var returnValues = GQLQueryContainerReturnValue(
            pageTitle: PageTitle(church: fellowship, pageTitle: 'Membership Attendance Trends'),
            body: body,
          );

          return returnValues;
        });
  }
}
