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

class ConstituencyMembershipScreen extends StatelessWidget {
  const ConstituencyMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getConstituencyMembershipNumbers,
      variables: {'id': churchState.constituencyId},
      defaultPageTitle: 'Constituency Members',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data) {
        Widget body;

        final constituency =
            ChurchForPaginatedMemberCounts.fromJson(data?['constituencies'][0]);

        ChurchWithPaginatedMemberQueries constituencyWithQueries = ChurchWithPaginatedMemberQueries(
          id: constituency.id,
          name: constituency.name,
          typename: constituency.typename,
          sheepCount: constituency.sheepPaginated?.totalCount ?? 0,
          sheepQuery: getConstituencySheepForList,
          goatCount: constituency.goatsPaginated?.totalCount ?? 0,
          goatQuery: getConstituencyGoatsForList,
          deerCount: constituency.deerPaginated?.totalCount ?? 0,
          deerQuery: getConstituencyDeerForList,
        );

        body = ChurchMembershipList(church: constituencyWithQueries);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: constituency, pageTitle: 'Membership'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
