import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/membership/gql_paginated_member_lists.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/utils_paginated_member_list.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class HubMembershipScreen extends StatelessWidget {
  const HubMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getHubMembershipNumbers,
      variables: {'id': churchState.hubId},
      defaultPageTitle: 'Hub Members',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data) {
        Widget body;

        final hub = ChurchForPaginatedMemberCounts.fromJson(data?['hubs'][0]);

        ChurchWithPaginatedMemberQueries hubWithQueries = ChurchWithPaginatedMemberQueries(
          id: hub.id,
          name: hub.name,
          typename: hub.typename,
          sheepCount: hub.sheepPaginated?.totalCount ?? 0,
          sheepQuery: getHubSheepForList,
          goatCount: hub.goatsPaginated?.totalCount ?? 0,
          goatQuery: getHubGoatsForList,
          deerCount: hub.deerPaginated?.totalCount ?? 0,
          deerQuery: getHubDeerForList,
        );

        body = ChurchMembershipList(church: hubWithQueries);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: hub, pageTitle: 'Membership'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
