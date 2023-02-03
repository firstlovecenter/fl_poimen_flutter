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

class CouncilOutstandingPrayerScreen extends StatelessWidget {
  const CouncilOutstandingPrayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getCouncilOutstandingPrayer,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Council Outstanding Prayers',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 2),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final council = ChurchForOutstandingPrayerList.fromJson(data?['councils'][0]);

        body = ChurchOutstandingPrayerList(church: council);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: council,
            pageTitle: 'Outstanding Prayers',
          ),
          body: body,
        );
      },
    );
  }
}
