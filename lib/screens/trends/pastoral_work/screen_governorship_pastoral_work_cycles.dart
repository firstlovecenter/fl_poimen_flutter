import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/trends/pastoral_work/gql_pastoral_work_trends.dart';
import 'package:poimen/screens/trends/pastoral_work/models_pastoral_work_trends.dart';
import 'package:poimen/screens/trends/pastoral_work/widget_pastoral_work_trends.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GovernorshipPastoralWorkCyclesScreen extends StatelessWidget {
  const GovernorshipPastoralWorkCyclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getGovernorshipPastoralWorkCycles,
        variables: {'id': churchState.governorshipId},
        defaultPageTitle: 'Pastoral Work Trends',
        bottomNavBar: const BottomNavBar(menu: getMyTrendsMenus, index: 1),
        bodyFunction: (data) {
          Widget body;

          final governorship =
              ChurchForPastoralWorkTrendsWithCounts.fromJson(data?['governorships'][0]);

          body = PastoralWorkTrendsWidget(
            church: governorship,
          );

          var returnValues = GQLQueryContainerReturnValue(
              pageTitle: PageTitle(
                church: governorship,
                pageTitle: 'Pastoral Work Trends',
              ),
              body: body);

          return returnValues;
        });
  }
}
