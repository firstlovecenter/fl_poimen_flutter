import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/gql_subchurch_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/grouped-by-subchurch/widget_church_by_subchurch_attedance_defaulters.dart';
import 'package:poimen/screens/attendance/defaulters/models_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class CouncilByConstituencyAttendanceDefaultersScreen extends StatelessWidget {
  const CouncilByConstituencyAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getCouncilAttendanceDefaultersByConstituency,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Attendance Defaulters',
      bottomNavBar: BottomNavBar(menu: getAttendanceMenus, index: 1),
      bodyFunction: (data) {
        Widget body;

        final council = ChurchBySubChurchForAttendanceDefaulters.fromJson(data?['councils'][0]);

        body = ChurchBySubChurchAttendanceDefaulters(church: council);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            pageTitle: 'Attendance Defaulters',
            church: council,
          ),
          body: body,
        );
      },
    );
  }
}
