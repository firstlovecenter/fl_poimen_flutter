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

class ConstituencyPastoralWorkCyclesScreen extends StatelessWidget {
  const ConstituencyPastoralWorkCyclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getConstituencyPastoralWorkCycles,
        variables: {'id': churchState.constituencyId},
        defaultPageTitle: 'Pastoral Work Trends',
        bottomNavBar: const BottomNavBar(menu: getMyTrendsMenus, index: 1),
        bodyFunction: (data) {
          Widget body;

          final constituency =
              ChurchForPastoralWorkTrendsWithCounts.fromJson(data?['constituencies'][0]);

          body = PastoralWorkTrendsWidget(
            church: constituency,
          );

          var returnValues = GQLQueryContainerReturnValue(
              pageTitle: PageTitle(
                church: constituency,
                pageTitle: 'Pastoral Work Trends',
              ),
              body: body);

          return returnValues;
        });
  }
}
