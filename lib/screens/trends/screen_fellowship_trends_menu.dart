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

class FellowshipTrendsScreen extends StatelessWidget {
  const FellowshipTrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getFellowshipTrendsMenu,
      variables: {'id': churchState.fellowshipId},
      bottomNavBar: const BottomNavBar(menu: getTrendsMenus, index: 1),
      defaultPageTitle: 'Trends Menu',
      bodyFunction: (data) {
        Widget body;

        final fellowship = ChurchForTrendsMenu.fromJson(data?['fellowships'][0]);

        body = WidgetTrendsMenu(
          church: fellowship,
          permittedRoles: permitRoleAndHigher(Role.leaderFellowship),
        );

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: fellowship, pageTitle: 'Trends Menu'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
