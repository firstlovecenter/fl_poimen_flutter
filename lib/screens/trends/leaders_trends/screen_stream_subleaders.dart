import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/trends/leaders_trends/gql_my_leaders_trends.dart';
import 'package:poimen/screens/trends/leaders_trends/models_my_leaders_trends.dart';
import 'package:poimen/screens/trends/leaders_trends/widget_subleaders_list.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class StreamSubLeadersTrendsScreen extends StatelessWidget {
  const StreamSubLeadersTrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getStreamSubLeaders,
      variables: {'id': churchState.streamId},
      defaultPageTitle: 'My Leaders',
      bottomNavBar: const BottomNavBar(menu: getTrendsMenus, index: 2),
      bodyFunction: (data) {
        Widget body;

        final stream = ChurchWithSubChurchList.fromJson(data?['streams'][0]);
        body = SubLeadersListWidget(church: stream);

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: churchState.church,
            pageTitle: 'My Council',
          ),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
