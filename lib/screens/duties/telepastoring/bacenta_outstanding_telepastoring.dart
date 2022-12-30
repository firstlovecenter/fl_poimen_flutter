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

class BacentaOutstandingTelepastoringScreen extends StatelessWidget {
  const BacentaOutstandingTelepastoringScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getBacentaOutstandingTelepastoring,
      variables: {'id': churchState.bacentaId},
      defaultPageTitle: 'Bacenta Outstanding Telepastorings',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 4),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final bacenta = ChurchForOutstandingTelepastoringList.fromJson(data?['bacentas'][0]);

        body = ChurchOutstandingTelepastoringList(church: bacenta);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: bacenta,
            pageTitle: 'Outstanding Telepastorings',
          ),
          body: body,
        );
      },
    );
  }
}
