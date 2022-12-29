import 'package:flutter/material.dart';
import 'package:poimen/duties/telepastoring/gql_telepastoring.dart';
import 'package:poimen/duties/telepastoring/models_telepastoring.dart';
import 'package:poimen/duties/telepastoring/widget_outstanding_telepastoring_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class ConstituencyOutstandingTelepastoringScreen extends StatelessWidget {
  const ConstituencyOutstandingTelepastoringScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getConstituencyOutstandingTelepastoring,
      variables: {'id': churchState.constituencyId},
      defaultPageTitle: 'Constituency Outstanding Telepastorings',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 4),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final constituency =
            ChurchForOutstandingTelepastoringList.fromJson(data?['constituencies'][0]);

        body = ChurchOutstandingTelepastoringList(church: constituency);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: constituency,
            pageTitle: 'Outstanding Telepastorings',
          ),
          body: body,
        );
      },
    );
  }
}
