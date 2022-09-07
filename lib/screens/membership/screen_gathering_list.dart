import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/gql_membership_list.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:poimen/widgets/page_title.dart';
import 'package:provider/provider.dart';

class GatheringMembershipScreen extends StatelessWidget {
  const GatheringMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getGatheringMembers,
      variables: {'id': churchState.gatheringId},
      defaultPageTitle: 'Gathering Members',
      bodyFunction: (data) {
        Widget body;

        final gathering = ChurchForMemberList.fromJson(data?['gatheringServices'][0]);

        body = ChurchMembershipList(church: gathering);
        var returnValues = GQLContainerReturnValue(
          pageTitle: PageTitle(church: gathering, pageTitle: 'Membership'),
          body: body,
        );

        return returnValues;
      },
    );
  }
}
