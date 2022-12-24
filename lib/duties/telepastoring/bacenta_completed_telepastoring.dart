import 'package:flutter/material.dart';
import 'package:poimen/duties/telepastoring/gql_telepastoring.dart';
import 'package:poimen/duties/telepastoring/models_telepastoring.dart';
import 'package:poimen/duties/telepastoring/widget_completed_telepastoring_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class BacentaCompletedTelepastoringScreen extends StatelessWidget {
  const BacentaCompletedTelepastoringScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getBacentaCompletedTelepastoring,
      variables: {'id': churchState.bacentaId},
      defaultPageTitle: 'Bacenta Completed Telepastorings',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 4),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final bacenta = ChurchForCompletedTelepastoringList.fromJson(data?['bacentas'][0]);

        body = ChurchCompletedTelepastoringList(church: bacenta);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: bacenta,
            pageTitle: 'Completed Telepastorings',
          ),
          body: body,
        );
      },
    );
  }
}
