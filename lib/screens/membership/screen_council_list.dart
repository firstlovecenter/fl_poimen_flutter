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

class CouncilMembershipScreen extends StatelessWidget {
  const CouncilMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getCouncilMembershipNumbers,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Council Members',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data) {
        Widget body;

        final council = ChurchForPaginatedMemberCounts.fromJson(data?['councils'][0]);

        ChurchWithPaginatedMemberQueries councilWithQueries = ChurchWithPaginatedMemberQueries(
          id: council.id,
          name: council.name,
          typename: council.typename,
          sheepCount: council.sheepPaginated?.totalCount ?? 0,
          sheepQuery: getCouncilSheepForList,
          goatCount: council.goatsPaginated?.totalCount ?? 0,
          goatQuery: getCouncilGoatsForList,
          deerCount: council.deerPaginated?.totalCount ?? 0,
          deerQuery: getCouncilDeerForList,
        );

        body = ChurchMembershipList(church: councilWithQueries);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: council, pageTitle: 'Membership'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
