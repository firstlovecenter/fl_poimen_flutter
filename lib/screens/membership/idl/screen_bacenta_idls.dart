import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/membership/idl/gql_bacenta_idls.dart';
import 'package:poimen/screens/membership/idl/models_idl.dart';
import 'package:poimen/screens/membership/idl/widget_idl_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class BacentaIDLScreen extends StatelessWidget {
  const BacentaIDLScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    return GQLQueryContainer(
      query: getBacentaIdls,
      variables: {'id': churchState.bacentaId},
      defaultPageTitle: 'Bacenta IDL List',
      bottomNavBar: const BottomNavBar(menu: getAttendanceMenus, index: 3),
      bodyFunction: (data, [fetchMore]) {
        Widget body;

        final bacenta = ChurchForIdlList.fromJson(data?['bacentas'][0]);

        body = ChurchIdlList(church: bacenta);

        return GQLQueryContainerReturnValue(
            pageTitle: PageTitle(
              church: bacenta,
              pageTitle: 'IDL List',
            ),
            body: body);
      },
    );
  }
}
