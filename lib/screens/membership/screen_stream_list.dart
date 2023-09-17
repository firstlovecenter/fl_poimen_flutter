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

class StreamMembershipScreen extends StatelessWidget {
  const StreamMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getStreamMembershipNumbers,
      variables: {'id': churchState.streamId},
      defaultPageTitle: 'Stream Members',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (data) {
        Widget body;

        final stream = ChurchForPaginatedMemberCounts.fromJson(data?['streams'][0]);

        ChurchWithPaginatedMemberQueries streamWithQueries = ChurchWithPaginatedMemberQueries(
          id: stream.id,
          name: stream.name,
          typename: stream.typename,
          sheepCount: stream.sheepPaginated?.totalCount ?? 0,
          sheepQuery: getStreamSheepForList,
          goatCount: stream.goatsPaginated?.totalCount ?? 0,
          goatQuery: getStreamGoatsForList,
          deerCount: stream.deerPaginated?.totalCount ?? 0,
          deerQuery: getStreamDeerForList,
        );

        body = ChurchMembershipList(church: streamWithQueries);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: stream, pageTitle: 'Membership'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
