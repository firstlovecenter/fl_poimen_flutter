import 'package:flutter/material.dart';
import 'package:poimen/screens/duties/telepastoring/gql_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/models_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/widget_outstanding_telepastoring_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GovernorshipOutstandingTelepastoringScreen extends StatelessWidget {
  const GovernorshipOutstandingTelepastoringScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getGovernorshipOutstandingTelepastoring,
      variables: {'id': churchState.governorshipId},
      defaultPageTitle: 'Governorship Outstanding Telepastorings',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 4),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final governorship =
            ChurchForOutstandingTelepastoringList.fromJson(data?['governorships'][0]);

        body = ChurchOutstandingTelepastoringList(church: governorship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: governorship,
            pageTitle: 'Outstanding Telepastorings',
          ),
          body: body,
        );
      },
    );
  }
}
