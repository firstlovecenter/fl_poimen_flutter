import 'package:flutter/material.dart';
import 'package:poimen/duties/visitation/gql_visitation.dart';
import 'package:poimen/duties/visitation/models_visitation.dart';
import 'package:poimen/duties/visitation/widget_outstanding_visitation_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class FellowshipOutstandingVisitationScreen extends StatelessWidget {
  const FellowshipOutstandingVisitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getFellowshipOutstandingVisitations,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Fellowship Outstanding Visitations',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 2),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final fellowship = ChurchForOutstandingVisitationList.fromJson(data?['fellowships'][0]);

        body = ChurchOutstandingVisitationList(church: fellowship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: fellowship,
            pageTitle: 'Outstanding Visitations',
          ),
          body: body,
        );
      },
    );
  }
}
