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

class CampusMembershipScreen extends StatelessWidget {
  const CampusMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getCampusMembershipNumbers,
      variables: {'id': churchState.campusId},
      defaultPageTitle: 'Campus Members',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data) {
        Widget body;

        final campus = ChurchForPaginatedMemberCounts.fromJson(data?['campuses'][0]);

        ChurchWithPaginatedMemberQueries campusWithQueries = ChurchWithPaginatedMemberQueries(
          id: campus.id,
          name: campus.name,
          typename: campus.typename,
          sheepCount: campus.sheepPaginated?.totalCount ?? 0,
          sheepQuery: getCampusSheepForList,
          goatCount: campus.goatsPaginated?.totalCount ?? 0,
          goatQuery: getCampusGoatsForList,
          deerCount: campus.deerPaginated?.totalCount ?? 0,
          deerQuery: getCampusDeerForList,
        );

        body = ChurchMembershipList(church: campusWithQueries);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: campus, pageTitle: 'Membership'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
