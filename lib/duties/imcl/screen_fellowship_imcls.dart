import 'package:flutter/material.dart';
import 'package:poimen/duties/imcl/gql_imcls.dart';
import 'package:poimen/duties/imcl/models_imcl.dart';
import 'package:poimen/duties/imcl/widget_imcl_list.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class FellowshipIMCLScreen extends StatelessWidget {
  const FellowshipIMCLScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getFellowshipImcls,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Fellowship IMCL List',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 2),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final fellowship = ChurchForImclList.fromJson(data?['fellowships'][0]);

        body = ChurchImclList(church: fellowship);

        return GQLQueryContainerReturnValue(
          pageTitle: PageTitle(
            church: fellowship,
            pageTitle: 'IMCL List',
          ),
          body: body,
        );
      },
    );
  }
}
