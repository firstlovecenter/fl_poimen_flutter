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

class FellowshipServicesScreen extends StatelessWidget {
  const FellowshipServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
        query: getFellowshipServices,
        variables: {'id': churchState.fellowshipId},
        defaultPageTitle: 'Fellowship Services',
        bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 1),
        bodyFunction: (data) {
          Widget body;

          final fellowship = ChurchForServicesList.fromJson(data?['fellowships'][0]);

          body = ChurchServicesList(services: fellowship.services);

          return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(pageTitle: 'Recent Services', church: fellowship),
            body: body,
          );
        });
  }
}
