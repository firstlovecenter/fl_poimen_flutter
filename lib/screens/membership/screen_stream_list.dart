import 'package:flutter/material.dart';
import 'package:poimen/helpers/menus.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/services/gql_query_container.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/bottom_nav_bar.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class StreamMembershipScreen extends StatelessWidget {
  const StreamMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLQueryContainer(
      query: getStreamMembers,
      variables: {'id': churchState.streamId},
      defaultPageTitle: 'Stream Members',
      bottomNavBar: BottomNavBar(menu: getAttendanceMenus, index: 4),
      bodyFunction: (Map<String, dynamic>? data) {
        Widget body;

        final stream = ChurchForMemberList.fromJson(data?['streams'][0]);

        body = ChurchMembershipList(church: stream);
        var returnValues = GQLQueryContainerReturnValue(
            pageTitle: PageTitle(
              pageTitle: 'Membership',
              church: stream,
            ),
            body: body);

        return returnValues;
      },
    );
  }
}
