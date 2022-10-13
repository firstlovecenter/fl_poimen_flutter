import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/widget_attedance_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GatheringAttendanceDefaultersScreen extends StatelessWidget {
  const GatheringAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getGatheringAttendanceDefaulters,
      variables: {'id': churchState.gatheringId},
      defaultPageTitle: 'Gathering Attendance Defaulters',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 1),
      bodyFunction: (data) {
        Widget body;

        final gathering = ChurchForAttendanceDefaulters.fromJson(data?['gatheringServices'][0]);

        body = ChurchAttendanceDefaulters(church: gathering);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            pageTitle: 'Attendance Defaulters',
            church: gathering,
          ),
          body: body,
        );
      },
    );
  }
}
