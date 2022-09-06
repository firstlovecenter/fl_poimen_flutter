import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/alert_box.dart';

class ConstituencyMembershipList extends StatelessWidget {
  const ConstituencyMembershipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getConstituencyMembers,
      variables: {'id': churchState.constituencyId},
      defaultPageTitle: 'Constituency Members',
      bodyFunction: (Map<String, dynamic>? data) {
        Widget body;
        String pageTitle;

        final constituency = ChurchForMemberList.fromJson(data?['constituencies'][0]);

        pageTitle = '${constituency.name} Constituency Membership';

        body = ChurchMembershipList(church: constituency);
        var returnValues = GQLContainerReturnValue(pageTitle: pageTitle, body: body);

        return returnValues;
      },
    );
  }
}
