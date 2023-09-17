import 'package:flutter/material.dart';
import 'package:poimen/screens/duties/prayer/gql_prayer.dart';
import 'package:poimen/screens/duties/prayer/models_prayer.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/duties/prayer/widget_outstanding_prayer_list.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class FellowshipOutstandingPrayerScreen extends StatelessWidget {
  const FellowshipOutstandingPrayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getFellowshipOutstandingPrayer,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Fellowship Outstanding Prayers',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 3),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final fellowship = ChurchForOutstandingPrayerList.fromJson(data?['fellowships'][0]);

        body = ChurchOutstandingPrayerList(church: fellowship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: fellowship,
            pageTitle: 'Outstanding Prayers',
          ),
          body: body,
        );
      },
    );
  }
}
