import 'package:flutter/material.dart';
import 'package:poimen/screens/duties/visitation/gql_visitation.dart';
import 'package:poimen/screens/duties/visitation/models_visitation.dart';
import 'package:poimen/screens/duties/visitation/widget_completed_visitation_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class FellowshipCompletedVisitationScreen extends StatelessWidget {
  const FellowshipCompletedVisitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getFellowshipCompletedVisitations,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Fellowship Completed Visitations',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 2),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final fellowship = ChurchForCompletedVisitationList.fromJson(data?['fellowships'][0]);

        body = ChurchCompletedVisitationList(church: fellowship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: fellowship,
            pageTitle: 'Completed Visitations',
          ),
          body: body,
        );
      },
    );
  }
}
