import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/gql_membership.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/widget_membership_list.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/widgets/gql_container.dart';
import 'package:provider/provider.dart';

class FellowshipMembershipList extends StatelessWidget {
  const FellowshipMembershipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var churchState = Provider.of<SharedState>(context);

    return GQLContainer(
      query: getFellowshipMembers,
      variables: {'id': churchState.fellowshipId},
      defaultPageTitle: 'Fellowship Members',
      bodyFunction: (Map<String, dynamic>? data) {
        Widget body;
        String pageTitle;

        final fellowship = ChurchForMemberList.fromJson(data?['fellowships'][0]);

        pageTitle = '${fellowship.name} Fellowship Membership';

        body = ChurchMembershipList(church: fellowship);
        var returnValues = GQLContainerReturnValue(pageTitle: pageTitle, body: body);

        return returnValues;
      },
    );
  }
}
