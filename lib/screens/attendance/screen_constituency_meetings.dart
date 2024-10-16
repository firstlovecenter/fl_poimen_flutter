import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/attendance/gql_services_list.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/screens/attendance/widget_services_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class ScreenConstituencyMeetings extends StatelessWidget {
  const ScreenConstituencyMeetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getGovernorshipMeetings,
        variables: {'id': churchState.constituencyId},
        defaultPageTitle: 'Constituency Services',
        bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 2),
        bodyFunction: (data, [fetchMore]) {
          Widget body;

          final constituency = ChurchForServicesList.fromJson(data?['constituencys'][0]);

          body = ChurchServicesList(services: constituency.services);

          return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(pageTitle: 'Recent Services', church: constituency),
            body: body,
          );
        });
  }
}
