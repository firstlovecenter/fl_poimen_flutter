import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/attendance/defaulters/gql_defaulters.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class ConstituencyAttendanceDefaultersScreen extends StatelessWidget {
  const ConstituencyAttendanceDefaultersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: constituencyAttendanceDefaulters,
      variables: {'id': churchState.constituencyId},
      defaultPageTitle: 'Constituency Attendance Defaulters',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus),
      bodyFunction: (data) {
        Widget body;

        body = Container();

        return GQLQueryContainerReturnValue(
          pageTitle: const PageTitle(
            pageTitle: 'Constituency Attendance Defaulters',
          ),
          body: body,
        );
      },
    );
  }
}
