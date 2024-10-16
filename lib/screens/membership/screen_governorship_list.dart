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

class GovernorshipMembershipScreen extends StatelessWidget {
  const GovernorshipMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getGovernorshipMembershipNumbers,
      variables: {'id': churchState.governorshipId},
      defaultPageTitle: 'Governorship Members',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data) {
        Widget body;

        final governorship = ChurchForPaginatedMemberCounts.fromJson(data?['governorships'][0]);

        ChurchWithPaginatedMemberQueries governorshipWithQueries = ChurchWithPaginatedMemberQueries(
          id: governorship.id,
          name: governorship.name,
          typename: governorship.typename,
          sheepCount: governorship.sheepPaginated?.totalCount ?? 0,
          sheepQuery: getGovernorshipSheepForList,
          goatCount: governorship.goatsPaginated?.totalCount ?? 0,
          goatQuery: getGovernorshipGoatsForList,
          deerCount: governorship.deerPaginated?.totalCount ?? 0,
          deerQuery: getGovernorshipDeerForList,
        );

        body = ChurchMembershipList(church: governorshipWithQueries);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: governorship, pageTitle: 'Membership'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
