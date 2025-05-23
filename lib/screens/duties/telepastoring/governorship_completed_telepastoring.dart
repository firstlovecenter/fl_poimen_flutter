import 'package:flutter/material.dart';
import 'package:poimen/screens/duties/telepastoring/gql_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/models_telepastoring.dart';
import 'package:poimen/screens/duties/telepastoring/widget_completed_telepastoring_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GovernorshipCompletedTelepastoringScreen extends StatelessWidget {
  const GovernorshipCompletedTelepastoringScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getGovernorshipCompletedTelepastoring,
      variables: {'id': churchState.governorshipId},
      defaultPageTitle: 'Governorship Completed Telepastorings',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 4),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final governorship =
            ChurchForCompletedTelepastoringList.fromJson(data?['governorships'][0]);

        body = ChurchCompletedTelepastoringList(church: governorship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: governorship,
            pageTitle: 'Completed Telepastorings',
          ),
          body: body,
        );
      },
    );
  }
}
