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

class FellowshipMembershipScreen extends StatelessWidget {
  const FellowshipMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getFellowshipMembershipNumbers,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Fellowship Members',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data) {
        Widget body;

        final fellowship = ChurchForPaginatedMemberCounts.fromJson(data?['fellowships'][0]);

        ChurchWithPaginatedMemberQueries fellowshipWithQueries = ChurchWithPaginatedMemberQueries(
          id: fellowship.id,
          name: fellowship.name,
          typename: fellowship.typename,
          sheepCount: fellowship.sheepPaginated?.totalCount ?? 0,
          sheepQuery: getFellowshipSheepForList,
          goatCount: fellowship.goatsPaginated?.totalCount ?? 0,
          goatQuery: getFellowshipGoatsForList,
          deerCount: fellowship.deerPaginated?.totalCount ?? 0,
          deerQuery: getFellowshipDeerForList,
        );

        body = ChurchMembershipList(church: fellowshipWithQueries);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: fellowship, pageTitle: 'Membership'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
