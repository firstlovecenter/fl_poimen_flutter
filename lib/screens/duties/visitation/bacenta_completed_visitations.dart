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

class BacentaCompletedVisitationScreen extends StatelessWidget {
  const BacentaCompletedVisitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getBacentaCompletedVisitations,
      variables: {'id': churchState.bacentaId},
      defaultPageTitle: 'Bacenta Completed Visitations',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 2),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final bacenta = ChurchForCompletedVisitationList.fromJson(data?['bacentas'][0]);

        body = ChurchCompletedVisitationList(church: bacenta);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: bacenta,
            pageTitle: 'Completed Visitations',
          ),
          body: body,
        );
      },
    );
  }
}
