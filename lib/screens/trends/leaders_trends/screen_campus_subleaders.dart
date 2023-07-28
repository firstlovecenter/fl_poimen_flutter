import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/trends/leaders_trends/gql_my_leaders_trends.dart';
import 'package:poimen/screens/trends/leaders_trends/models_my_leaders_trends.dart';
import 'package:poimen/screens/trends/leaders_trends/widget_campus_subleaders_list.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class CampusSubLeadersTrendsScreen extends StatelessWidget {
  const CampusSubLeadersTrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getCampusSubLeaders,
      variables: {'id': churchState.campusId},
      defaultPageTitle: 'My Streams',
      bottomNavBar: const BottomNavBar(menu: getTrendsMenus, index: 2),
      bodyFunction: (data) {
        Widget body;

        final campus = CampusWithSubChurchList.fromJson(data?['campuses'][0]);
        body = CampusSubLeadersListWidget(church: campus);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: churchState.church,
            pageTitle: 'My Streams',
          ),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
