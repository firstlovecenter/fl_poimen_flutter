import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/trends/gql_trends.dart';
import 'package:poimen/screens/trends/models_trends.dart';
import 'package:poimen/screens/trends/widget_trends_menu.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class CampusTrendsScreen extends StatelessWidget {
  const CampusTrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getCampusTrendsMenu,
      variables: {'id': churchState.campusId},
      bottomNavBar: const BottomNavBar(menu: getTrendsMenus, index: 1),
      defaultPageTitle: 'Trends Menu',
      bodyFunction: (data) {
        Widget body;

        final campus = ChurchForTrendsMenu.fromJson(data?['campuses'][0]);

        body = WidgetTrendsMenu(
          church: campus,
          permittedRoles: permitRoleAndHigher(Role.leaderCampus),
        );

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: campus, pageTitle: 'Trends Menu'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
