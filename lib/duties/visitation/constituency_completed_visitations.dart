import 'package:flutter/material.dart';
import 'package:poimen/duties/visitation/gql_visitation.dart';
import 'package:poimen/duties/visitation/models_visitation.dart';
import 'package:poimen/duties/visitation/widget_completed_visitation_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class ConstituencyCompletedVisitationScreen extends StatelessWidget {
  const ConstituencyCompletedVisitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getConstituencyCompletedVisitations,
      variables: {'id': churchState.constituencyId},
      defaultPageTitle: 'Constituency Completed Visitations',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 1),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final constituency = ChurchForCompletedVisitationList.fromJson(data?['constituencies'][0]);

        body = ChurchCompletedVisitationList(church: constituency);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: constituency,
            pageTitle: 'Completed Visitations',
          ),
          body: body,
        );
      },
    );
  }
}
