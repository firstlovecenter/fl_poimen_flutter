import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/trends/gql_trends.dart';
import 'package:poimen/screens/trends/models_trends.dart';
import 'package:poimen/screens/trends/widget_trends_menu.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class StreamTrendsScreen extends StatelessWidget {
  const StreamTrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getStreamTrendsMenu,
      variables: {'id': churchState.streamId},
      bottomNavBar: const BottomNavBar(menu: getTrendsMenus, index: 1),
      defaultPageTitle: 'Trends Menu',
      bodyFunction: (data) {
        Widget body;

        final stream = ChurchForTrendsMenu.fromJson(data?['streams'][0]);

        body = WidgetTrendsMenu(
          church: stream,
          permittedRoles: const [Role.leaderStream],
        );

        var returnValues = GQLQueryContainerReturnValue(
          pageTitle: PageTitle(church: stream, pageTitle: 'Trends Menu'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
