import 'package:flutter/material.dart';
import 'package:poimen/screens/duties/prayer/gql_prayer.dart';
import 'package:poimen/screens/duties/prayer/models_prayer.dart';
import 'package:poimen/screens/duties/prayer/widget_completed_prayer_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class FellowshipCompletedPrayerScreen extends StatelessWidget {
  const FellowshipCompletedPrayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getFellowshipCompletedPrayer,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Fellowship Completed Prayers',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 3),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final fellowship = ChurchForCompletedPrayerList.fromJson(data?['fellowships'][0]);

        body = ChurchCompletedPrayerList(church: fellowship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: fellowship,
            pageTitle: 'Completed Prayers',
          ),
          body: body,
        );
      },
    );
  }
}
