import 'package:flutter/material.dart';
import 'package:poimen/screens/duties/imcl/gql_imcls.dart';
import 'package:poimen/screens/duties/imcl/models_imcl.dart';
import 'package:poimen/screens/duties/imcl/widget_imcl_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class ConstituencyIMCLScreen extends StatelessWidget {
  const ConstituencyIMCLScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getConstituencyImcls,
      variables: {'id': churchState.constituencyId},
      defaultPageTitle: 'Constituency IMCL List',
      bottomNavBar: const BottomNavBar(menu: getDutiesMenus, index: 1),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final constituency = ChurchForImclList.fromJson(data?['constituencies'][0]);

        body = ChurchImclList(church: constituency);

        return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(
              church: constituency,
              pageTitle: 'IMCL List',
            ),
            body: body);
      },
    );
  }
}
