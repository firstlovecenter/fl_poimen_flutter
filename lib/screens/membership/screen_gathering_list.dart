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

class GatheringMembershipScreen extends StatelessWidget {
  const GatheringMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getGatheringMembershipNumbers,
      variables: {'id': churchState.gatheringId},
      defaultPageTitle: 'Gathering Members',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data) {
        Widget body;

        final gathering = ChurchForPaginatedMemberCounts.fromJson(data?['gatheringServices'][0]);

        ChurchWithPaginatedMemberQueries gatheringWithQueries = ChurchWithPaginatedMemberQueries(
          id: gathering.id,
          name: gathering.name,
          typename: gathering.typename,
          sheepCount: gathering.sheepPaginated?.totalCount ?? 0,
          sheepQuery: getGatheringSheepForList,
          goatCount: gathering.goatsPaginated?.totalCount ?? 0,
          goatQuery: getGatheringGoatsForList,
          deerCount: gathering.deerPaginated?.totalCount ?? 0,
          deerQuery: getGatheringDeerForList,
        );

        body = ChurchMembershipList(church: gatheringWithQueries);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: gathering, pageTitle: 'Membership'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
