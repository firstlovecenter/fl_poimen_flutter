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

class FellowshipOutstandingTelepastoringScreen extends StatelessWidget {
  const FellowshipOutstandingTelepastoringScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getFellowshipOutstandingTelepastoring,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Fellowship Outstanding Telepastorings',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 4),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final fellowship = ChurchForOutstandingTelepastoringList.fromJson(data?['fellowships'][0]);

        body = ChurchOutstandingTelepastoringList(church: fellowship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: fellowship,
            pageTitle: 'Outstanding Telepastorings',
          ),
          body: body,
        );
      },
    );
  }
}
