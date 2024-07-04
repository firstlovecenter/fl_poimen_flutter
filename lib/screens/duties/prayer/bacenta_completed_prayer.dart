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

class BacentaCompletedPrayerScreen extends StatelessWidget {
  const BacentaCompletedPrayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getBacentaCompletedPrayer,
      variables: {'id': churchState.bacentaId},
      defaultPageTitle: 'Bacenta Completed Prayers',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 3),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final bacenta = ChurchForCompletedPrayerList.fromJson(data?['bacentas'][0]);

        body = ChurchCompletedPrayerList(church: bacenta);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: bacenta,
            pageTitle: 'Completed Prayers',
          ),
          body: body,
        );
      },
    );
  }
}
