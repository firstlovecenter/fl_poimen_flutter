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

class ScreenGovernorshipMeetings extends StatelessWidget {
  const ScreenGovernorshipMeetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getGovernorshipMeetings,
        variables: {'id': churchState.governorshipId},
        defaultPageTitle: 'Governorship Services',
        bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 2),
        bodyFunction: (data, [fetchMore]) {
          Widget body;

          final governorship = ChurchForServicesList.fromJson(data?['governorships'][0]);

          body = ChurchServicesList(services: governorship.services);

          return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(pageTitle: 'Recent Services', church: governorship),
            body: body,
          );
        });
  }
}
