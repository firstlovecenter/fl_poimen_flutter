import 'package:flutter/material.dart';
import 'package:poimen/screens/duties/prayer/gql_prayer.dart';
import 'package:poimen/screens/duties/prayer/models_prayer.dart';
import 'package:poimen/screens/duties/prayer/widget_outstanding_prayer_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GovernorshipOutstandingPrayerScreen extends StatelessWidget {
  const GovernorshipOutstandingPrayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getGovernorshipOutstandingPrayer,
      variables: {'id': churchState.governorshipId},
      defaultPageTitle: 'Governorship Outstanding Prayers',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 2),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final governorship = ChurchForOutstandingPrayerList.fromJson(data?['governorships'][0]);

        body = ChurchOutstandingPrayerList(church: governorship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: governorship,
            pageTitle: 'Outstanding Prayers',
          ),
          body: body,
        );
      },
    );
  }
}
