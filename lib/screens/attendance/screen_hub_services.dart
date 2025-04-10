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

class HubRehearsalsScreen extends StatelessWidget {
  const HubRehearsalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
        query: getHubServices,
        variables: {'id': churchState.hubId},
        defaultPageTitle: 'Hub Rehearsals',
        bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 1),
        bodyFunction: (data, [fetchMore]) {
          Widget body;

          final hub = ChurchForServicesList.fromJson(data?['hubs'][0]);

          body = ChurchServicesList(services: hub.services);

          return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(pageTitle: 'Recent Rehearsals', church: hub),
            body: body,
          );
        });
  }
}
