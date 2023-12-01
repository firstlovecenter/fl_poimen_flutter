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

class BacentaMembershipScreen extends StatelessWidget {
  const BacentaMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getBacentaMembershipNumbers,
      variables: {'id': churchState.bacentaId},
      defaultPageTitle: 'Bacenta Members',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data) {
        Widget body;

        final bacenta = ChurchForPaginatedMemberCounts.fromJson(data?['bacentas'][0]);

        ChurchWithPaginatedMemberQueries bacentaWithQueries = ChurchWithPaginatedMemberQueries(
          id: bacenta.id,
          name: bacenta.name,
          typename: bacenta.typename,
          sheepCount: bacenta.sheepPaginated?.totalCount ?? 0,
          sheepQuery: getBacentaSheepForList,
          goatCount: bacenta.goatsPaginated?.totalCount ?? 0,
          goatQuery: getBacentaGoatsForList,
          deerCount: bacenta.deerPaginated?.totalCount ?? 0,
          deerQuery: getBacentaDeerForList,
        );

        body = ChurchMembershipList(church: bacentaWithQueries);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: bacenta, pageTitle: 'Membership'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
