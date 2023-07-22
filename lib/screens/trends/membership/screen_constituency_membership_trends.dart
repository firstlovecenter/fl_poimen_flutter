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

class ConstituencyMembershipAttendanceScreen extends StatelessWidget {
  const ConstituencyMembershipAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
        query: getConstituencyMembershipAttendanceTrends,
        variables: {'id': churchState.constituencyId},
        bottomNavBar: const BottomNavBar(menu: getMyTrendsMenus, index: 2),
        defaultPageTitle: 'Membership Attendance Trends',
        bodyFunction: (data) {
          Widget body;

          final constituency =
              ChurchForMembershipAttendanceTrends.fromJson(data?['constituencies'][0]);

          body = MembershipTrendsWidget(
            church: constituency,
          );

          var returnValues = GQLQueryContainerReturnValue(
            pageTitle: PageTitle(church: constituency, pageTitle: 'Membership Attendance Trends'),
            body: body,
          );

          return returnValues;
        });
  }
}
