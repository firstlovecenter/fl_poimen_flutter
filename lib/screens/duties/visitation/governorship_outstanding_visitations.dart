import 'package:flutter/material.dart';
import 'package:poimen/screens/duties/visitation/gql_visitation.dart';
import 'package:poimen/screens/duties/visitation/models_visitation.dart';
import 'package:poimen/screens/duties/visitation/widget_outstanding_visitation_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GovernorshipOutstandingVisitationScreen extends StatelessWidget {
  const GovernorshipOutstandingVisitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getGovernorshipOutstandingVisitations,
      variables: {'id': churchState.governorshipId},
      defaultPageTitle: 'Governorship Outstanding Visitations',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 1),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final governorship = ChurchForOutstandingVisitationList.fromJson(data?['governorships'][0]);

        body = ChurchOutstandingVisitationList(church: governorship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: governorship,
            pageTitle: 'Outstanding Visitations',
          ),
          body: body,
        );
      },
    );
  }
}
