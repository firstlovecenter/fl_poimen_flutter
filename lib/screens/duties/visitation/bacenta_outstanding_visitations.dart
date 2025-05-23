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

class BacentaOutstandingVisitationScreen extends StatelessWidget {
  const BacentaOutstandingVisitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getBacentaOutstandingVisitations,
      variables: {'id': churchState.bacentaId},
      defaultPageTitle: 'Bacenta Outstanding Visitations',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 2),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final bacenta = ChurchForOutstandingVisitationList.fromJson(data?['bacentas'][0]);

        body = ChurchOutstandingVisitationList(church: bacenta);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: bacenta,
            pageTitle: 'Outstanding Visitations',
          ),
          body: body,
        );
      },
    );
  }
}
