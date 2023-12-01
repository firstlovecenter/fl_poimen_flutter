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

class CouncilCompletedPrayerScreen extends StatelessWidget {
  const CouncilCompletedPrayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getCouncilCompletedPrayer,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Council Completed Prayers',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 2),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final council = ChurchForCompletedPrayerList.fromJson(data?['councils'][0]);

        body = ChurchCompletedPrayerList(church: council);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: council,
            pageTitle: 'Completed Prayers',
          ),
          body: body,
        );
      },
    );
  }
}
