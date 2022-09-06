import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/gql_membership.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/alert_box.dart';

class GatheringMembershipList extends StatelessWidget {
  const GatheringMembershipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getGatheringMembers,
      variables: {'id': churchState.gatheringId},
      defaultPageTitle: 'Gathering Members',
      bodyFunction: (Map<String, dynamic>? data) {
        Widget body;
        String pageTitle;

        final gathering = ChurchForMemberList.fromJson(data?['gatheringServices'][0]);

        pageTitle = '${gathering.name} Gathering Membership';

        body = ChurchMembershipList(church: gathering);
        var returnValues = GQLContainerReturnValue(pageTitle: pageTitle, body: body);

        return returnValues;
      },
    );
  }
}
