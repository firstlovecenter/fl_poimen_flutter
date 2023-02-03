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

class CouncilOutstandingVisitationScreen extends StatelessWidget {
  const CouncilOutstandingVisitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getCouncilOutstandingVisitations,
      variables: {'id': churchState.councilId},
      defaultPageTitle: 'Council Outstanding Visitations',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 1),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final council =
            ChurchForOutstandingVisitationList.fromJson(data?['councils'][0]);

        body = ChurchOutstandingVisitationList(church: council);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: council,
            pageTitle: 'Outstanding Visitations',
          ),
          body: body,
        );
      },
    );
  }
}
