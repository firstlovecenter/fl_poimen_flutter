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

class CouncilCompletedVisitationScreen extends StatelessWidget {
  const CouncilCompletedVisitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getCouncilCompletedVisitations,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Council Completed Visitations',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 1),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final council = ChurchForCompletedVisitationList.fromJson(data?['councils'][0]);

        body = ChurchCompletedVisitationList(church: council);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: council,
            pageTitle: 'Completed Visitations',
          ),
          body: body,
        );
      },
    );
  }
}
